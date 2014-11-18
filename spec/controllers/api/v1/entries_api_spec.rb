require "spec_helper"

describe Api::V1::EntriesController, type: :controller do

  let(:user) { create :user }
  before(:each) do
    sign_in(user)
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  context "find a user's entries" do
    it "see it's glory" do
      entry = create :hbi_entry, user: user
      with_resque{entry.save}; entry.reload
      get :show, id: entry.date.to_s
      expect(response.body).to be_json_eql EntrySerializer.new(entry).to_json
      returns_code 200
    end
    it "it isn't found" do
      get :show, id: 1.year.ago.to_date
      expect(response.body).to be_json_eql({error: "Not found."}.to_json)
      returns_code 404
    end
  end

  context "entry creation" do

    it "authenticated user creates entry" do
      post :create, entry: entry_attributes.to_json
      expect(user.entries.first.stools).to eq entry_attributes[:responses].detect{|q| q[:name] == :stools}[:value]
      expect(user.entries.first.date).to eq Date.parse("2014-09-22")
      returns_code 201
    end

    it "returns nested errors for bad response values" do
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == :stools}.first[:value] = 999999

      post :create, entry: attrs.to_json

      expect(json_response["errors"]).to be_present
      expect(json_response["errors"]["responses"]).to be_present
      expect(json_response["errors"]["responses"]["stools"]).to eq "Not within allowed values"

      returns_code 422
    end

    # it "missing something" do
    #   invalid_attrs = entry_attributes; invalid_attrs[:responses].delete("stools")
    #   post entries_path({entry: invalid_attrs}.merge(api_credentials(user)))
    #   expect(json_response["errors"].keys).to include("stools")
    #   returns_code 422
    # end
  end

  context "update a entry" do

    let(:entry) { create :hbi_entry, user: user, responses: [{name: :stools, value: 2}] }
    it "successfully updated" do
      expect(entry.stools).to eq 2

      attrs = entry_attributes
      attrs[:responses].detect{|q| q[:name] == :stools}[:value] = 3

      put :update, id: entry.date.to_s, entry: attrs.to_json


      expect(entry.reload.stools).to eq 3
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
      expect(entry.stools).to eq 0

      attrs = entry_attributes
      attrs[:responses].detect{|q| q[:name] == :stools}[:value] = 1


      patch :update, id: entry.date.to_s, entry: attrs.to_json
      expect(entry.reload.stools).to eq 1

      returns_code 200
    end

    it "response with bad value" do
      attrs = entry_attributes
      attrs[:responses].detect{|q| q[:name] == :stools}[:value] = "valuenogood"

      patch :update, id: entry.date.to_s, entry: attrs.to_json
      returns_code 422
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
    catalogs: ["hbi"],
    date: "2014-09-22",
    responses: response_attributes.map{|r| {name: r.first, value: r.last}}
  }
end