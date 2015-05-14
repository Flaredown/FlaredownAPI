require "spec_helper"

describe V1::EntriesController, type: :controller do

  let(:user) { create :user, created_at: 10.days.ago }
  before(:each) do
    sign_in(user)
    Timecop.return
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  it "bad date" do
    get :show, id: "xyz"

    returns_groovy_error(name: "invalid_date", code: 400)
  end

  context "SHOW" do
    it "see it's glory" do
      entry = create :hbi_entry, user: user
      with_resque{entry.save}; entry.reload

      get :show, id: entry.date.to_s

      expect(response.body).to be_json_eql EntrySerializer.new(entry).to_json

      returns_code 200
    end

    it "shows specific keys" do
      entry = create :hbi_entry, user: user
      with_resque{entry.save}; entry.reload

      get :show, id: entry.date.to_s

      expect(response.body).to be_json_eql EntrySerializer.new(entry).to_json

      returns_code 200

      expect(json_response["entry"].keys.sort).to eql %w( id date catalogs responses treatments notes tags complete just_created ).sort
    end

    it "can't be accessed by another user" do
      another_user = create :user
      entry = create :hbi_entry, user: another_user
      with_resque{entry.save}; entry.reload

      get :show, id: entry.date.to_s
      returns_groovy_error(name: "404")
    end

    it "it isn't found" do
      get :show, id: 1.year.ago.to_date

      returns_groovy_error(name: "404")
    end
  end

  context "CREATE" do

    it "authenticated user creates entry" do
      today = user.created_at.to_date
      Timecop.freeze(today.to_time)
      post :create, date: today.strftime("%b-%d-%Y")

      expect(user.entries.first.date).to eq today
      expect(json_response["entry"].keys.sort).to eql %w( id date catalogs catalog_definitions treatments complete just_created ).sort

      returns_code 201
    end

    it "entry already exists" do
      today = user.created_at.to_date
      Timecop.freeze(today.to_time)

      entry = create :hbi_entry, user: user, date: today
      post :create, date: today.strftime("%b-%d-%Y")

      expect(json_response["entry"].keys).to include "catalog_definitions"

      expect(json_response["entry"]["responses"].detect{|q| q["name"] == "stools"}["value"]).to eq user.entries.first.hbi_stools
      expect(today).to eq user.entries.first.date

      returns_code 200
    end

    context "TIME TRAVEL" do
      it "is a past date within allowed range" do
        today = user.created_at.to_date+10.days
        Timecop.freeze(today.to_time)

        entry_date = today-5.days
        post :create, date: (entry_date).strftime("%b-%d-%Y")
        expect(user.entries.first.date).to eq entry_date

        returns_code 201
      end

      it "is before first audit date (not allowed)" do
        today = user.created_at.to_date+10.days
        Timecop.freeze(today.to_time)

        post :create, date: user.created_at.to_date-1.day

        returns_groovy_error(name: "no_checkins_before_signup")
      end

      it "is a date in the future (not allowed)" do
        post :create, date: "Sep-22-3000"
        returns_groovy_error(name: "future_date")
      end

      it "is a date too far in the past (not allowed)" do
        today = user.created_at.to_date+30.days
        Timecop.freeze(today.to_time)

        post :create, date: (today-15.days).strftime("%b-%d-%Y")
        returns_groovy_error(name: "distant_past_date")
      end

    end

  end

  context "UPDATE" do

    let(:entry) { create :hbi_entry, user: user, responses: [{catalog: "hbi", name: :stools, value: 2}] }

    it "successfully updated" do
      expect(entry.hbi_stools).to eq 2

      attrs = entry_attributes
      attrs[:responses].detect{|q| q[:name] == :stools}[:value] = 3

      put :update, id: entry.date.to_s, entry: attrs.to_json

      expect(entry.reload.hbi_stools).to eq 3
      expect(entry.treatments.map(&:name)).to match_array ["Tickles", "Tickles", "Orange Juice"]
      expect(entry.tags).to eq ["crazy", "banana", "banzai"]
      returns_code 200
    end

    it "expects OK response" do
      create :hbi_entry, user: user

      patch :update, id: entry.date.to_s, entry: entry_attributes.to_json

      expect(json_response["success"]).to eql true
      returns_code 200
    end

    it "successfully updated with true/false response" do
      entry.responses.detect{|q| q.name == "stools"}.value = 0
      expect(entry.hbi_stools).to eq 0

      attrs = entry_attributes
      attrs[:responses].detect{|q| q[:name] == :stools}[:value] = 1


      patch :update, id: entry.date.to_s, entry: attrs.to_json
      expect(entry.reload.hbi_stools).to eq 1

      returns_code 200
    end

    it "doesn't update user treatment settings when no dosage info present" do
      entry = create :hbi_entry, date: Date.today, user: user

      attrs = entry_attributes
      attrs[:date] = entry.date.to_s

      with_resque{ patch :update, id: entry.date.to_s, entry: attrs.to_json }

      entry.reload
      entry.user.reload
      expect(entry.user.settings["treatment_Tickles_quantity"]).to eq "1.0"
      expect(entry.user.settings["treatment_Tickles_unit"]).to eq "session"

      attrs[:treatments] = [{name: "Tickles", quantity: false, unit: false}]

      with_resque{ patch :update, id: entry.date.to_s, entry: attrs.to_json }

      entry.reload
      entry.user.reload
      expect(entry.user.settings["treatment_Tickles_quantity"]).to eq "1.0"
      expect(entry.user.settings["treatment_Tickles_unit"]).to eq "session"
    end

    it "allows duplicate treatments" do
      entry = create :hbi_entry, date: Date.today, user: user

      attrs = entry_attributes
      attrs[:date] = entry.date.to_s

      with_resque{ patch :update, id: entry.date.to_s, entry: attrs.to_json }

      entry.reload
      expect(entry.treatments.map(&:name).length).to eq 3
      expect(entry.treatments.map(&:name).uniq.length).to eq 2
    end

    it "duplicate treatments" do
      entry = create :hbi_entry, date: Date.today, user: user

      attrs = entry_attributes
      attrs[:date] = entry.date.to_s

      with_resque{ patch :update, id: entry.date.to_s, entry: attrs.to_json }

      entry.reload
      tickles = entry.treatments.select{|t| t.name == "Tickles"}
      expect(tickles.length).to eq 2
      expect(tickles.first.repetition).to eql 1
      expect(tickles.last.repetition).to eql 2
    end

    it "returns nested errors for bad response values" do
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == :stools}.first[:value] = 999999

      patch :update, id: entry.date.to_s, entry: attrs.to_json

      returns_groovy_error(model_name: "entry", fields: [["stools", "not_within_allowed_values"]])
    end

  end
  context "Auditing on UPDATE", :disabled => true do

    it "adds a new version if it's the latest", versioning: true do
      user.user_conditions.activate create(:condition, name: "Crohn's disease")
      entry = create :hbi_entry, date: Date.today, user: user

      expect(user.versions.count).to eql 1
      expect(entry.using_latest_audit?).to be_true

      with_resque do
        put :update, id: entry.date.to_s, entry: {responses:[]}.to_json # no more Crohn's disease
      end

      expect(user.reload.versions.count).to eql 2
    end

    it "doesn't add a new audit when updating old entries", versioning: true do
      user.user_conditions.activate create(:condition, name: "Crohn's disease")
      entry = create :hbi_entry, date: Date.yesterday, user: user


      expect(user.versions.count).to eql 1 # for user creation, 10 days ago
      user.create_audit                    # creates audit for today

      expect(user.versions.count).to eql 2
      expect(entry.using_latest_audit?).to be_false

      with_resque do
        put :update, id: entry.date.to_s, entry: {responses:[]}.to_json  # no more Crohn's disease
      end

      # expect(EntryAuditUpdate).to have_queue_size_of(1)
      expect(user.versions.count).to eql 2
    end

    it "updates User actives based on the Entry content", versioning: true do
      user.user_conditions.activate create(:condition, name: "Crohn's disease")
      create :treatment, name: "Snake Oil"
      entry = create :hbi_entry, date: Date.today, user: user

      expect(user.versions.count).to eql 1
      # expect(user.active_catalogs).to include("hbi")

      with_resque do
        put :update, id: entry.date.to_s, entry: {responses:[]}.to_json
      end

      user.reload
      expect(user.active_catalogs).to_not include("hbi")
      expect(user.versions.count).to eql 2
      expect(user.active_catalogs).to be_empty

      with_resque do
        put :update, id: entry.date.to_s, entry: {treatments:[{name: "Snake Oil", quantity: 10, unit: "cc"}]}.to_json
      end

      user.reload
      expect(user.versions.count).to eql 3
      expect(user.active_treatments.map(&:name)).to eql ["Snake Oil"]
    end

  end
end

def response_attributes
  {
    general_wellbeing: 4,
    ab_pain: 1,
    stools: 2,
    ab_mass: 2,
    complication_arthralgia: 1,
    complication_uveitis: 0,
    complication_erythema_nodosum: 1,
    complication_aphthous_ulcers: 0,
    complication_anal_fissure: 0,
    complication_fistula: 1,
    complication_abscess: 0,
  }
end
def entry_attributes
  {
    date: "Sep-22-2014",
    responses: response_attributes.map{|r| {catalog: "hbi", name: r.first, value: r.last}},
    tags: ["crazy", "banana", "banzai"],
    treatments: [
      {name: "Tickles", quantity: "1.0", unit: "session"},
      {name: "Tickles", quantity: "1.0", unit: "session"},
      {name: "Orange Juice", quantity: "1.0", unit: "l"},
    ]
  }
end
