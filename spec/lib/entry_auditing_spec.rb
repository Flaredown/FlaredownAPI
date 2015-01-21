require 'spec_helper'

describe EntryAuditing do

  # TODO Fix conditions being added on with versioning properly

  let(:target_date) { Date.parse("Aug-13-2014").to_datetime.beginning_of_day }
  let!(:user) { create :user, created_at: 10.years.ago }
  let!(:entry) { build :entry, user_id: user.id.to_s, date: target_date.to_date }

  before(:each) do
    date = target_date - 10.days

    # Do some version stuffs, setup a history
    Timecop.travel(date)            # now Aug 3
    # === #
    user.create_audit               # v1

    user.user_conditions.activate   create(:condition, name: "allergies")
    user.user_symptoms.activate     create(:symptom, name: "runny nose")
    user.user_symptoms.activate     create(:symptom, name: "itchy throat")
    user.create_audit               # v2

    Timecop.travel(date+1.days)     # now Aug 4
    # === #
    user.user_treatments.activate   create(:treatment, name: "loratadine", quantity: 10.0, unit: "mg")
    user.create_audit               # v3

    Timecop.travel(date+9.days)     # now Aug 12
    # === #
    user.user_conditions.activate   create(:condition,name: "back pain")
    user.user_treatments.activate   create(:treatment, name: "sinus rinse", quantity: 1.0, unit: "session")
    user.create_audit               # v4

    # --- Target Date for Entry --- #

    Timecop.travel(date+11.days)    # now Aug 14
    # === #
    user.user_conditions.activate   create(:condition,name: "ticklishness")
    user.user_conditions.deactivate Condition.find_by(name: "back pain")
    user.user_treatments.activate   create(:treatment, name: "advil", quantity: 2.0, unit: "pill")
    user.user_symptoms.deactivate   Symptom.find_by(name: "itchy throat")
    user.create_audit               # v5

    Timecop.return
  end

  it "has 5 audit versions", versioning: true do
    expect(PaperTrail).to be_enabled
    expect(user.versions.count).to eql 5+1 # updates + v0 event
  end

  it "has various conditions/treatments/symptoms at different versions", versioning: true do

    entry = Entry.new(user_id: user.id, date: Date.parse("Aug-02-2014").to_datetime.end_of_day).setup_with_audit!
    expect(entry.conditions).to                                               be_empty
    expect(entry.treatments.map(&:name)).to                                   be_empty
    expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to be_empty

    entry = Entry.new(user_id: user.id, date: Date.parse("Aug-03-2014").to_datetime.end_of_day).setup_with_audit!
    expect(entry.conditions).to                                               eql %w( allergies )
    expect(entry.treatments.map(&:name)).to                                   be_empty
    expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose itchy\ throat )

    entry = Entry.new(user_id: user.id, date: Date.parse("Aug-04-2014").to_datetime.end_of_day).setup_with_audit!
    expect(entry.conditions).to                                               eql %w( allergies )
    expect(entry.treatments.map(&:name)).to                                   eql %w( loratadine )
    expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose itchy\ throat )

    entry = Entry.new(user_id: user.id, date: Date.parse("Aug-12-2014").to_datetime.end_of_day).setup_with_audit!
    expect(entry.conditions).to                                               eql %w( allergies back\ pain )
    expect(entry.treatments.map(&:name)).to                                   eql %w( loratadine sinus\ rinse )
    expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose itchy\ throat )

    entry = Entry.new(user_id: user.id, date: Date.parse("Aug-14-2014").to_datetime.end_of_day).setup_with_audit!
    expect(entry.conditions).to                                               eql %w( allergies ticklishness )
    expect(entry.treatments.map(&:name)).to                                   eql %w( loratadine sinus\ rinse advil )
    expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose )
  end

  describe "#applicable_audit" do
    it "gets the applicable audit version", versioning: true do
      audit = entry.applicable_audit # Get version closest (looking pastwards) to the target entry

      expect(audit.created_at.strftime("%b-%d-%Y")).to eql (target_date-1.day).strftime("%b-%d-%Y")
    end
  end

  describe "#using_latest_audit?" do
    it "returns true if there are no future audits ahead of it", versioning: true do
      entry.date = Date.parse("Aug-15-2014").to_datetime.end_of_day
      expect(entry.using_latest_audit?).to be_true

      user.create_audit
      expect(entry.using_latest_audit?).to be_false
    end
    it "returns true if there is no applicable audit", versioning: false do
      entry.date = Date.today
      expect(entry.using_latest_audit?).to be_true
    end
    it "false if there are future audits", versioning: true do
      entry.date = Date.parse("Aug-12-2014").to_datetime.end_of_day
      expect(entry.using_latest_audit?).to be_false
    end
  end

  describe "#setup_with_audit!" do
    it "adds to the entry based on audit contents", versioning: true do
      entry.setup_with_audit!

      expect(entry).to be_an Entry
      expect(entry.conditions).to eql %w( allergies back\ pain )
      expect(entry.treatments.map(&:name)).to eql %w( loratadine sinus\ rinse )
      expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose itchy\ throat )
    end

    it "matches latest version correctly", versioning: true do
      entry.date = Date.today
      entry.setup_with_audit!

      expect(entry.applicable_audit.created_at.strftime("%b-%d-%Y")).to eql (target_date+1.day).strftime("%b-%d-%Y")

      expect(entry.conditions).to eql %w( allergies ticklishness )
      expect(entry.treatments.map(&:name)).to eql %w( loratadine sinus\ rinse advil )
      expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose )
    end
  end


end
