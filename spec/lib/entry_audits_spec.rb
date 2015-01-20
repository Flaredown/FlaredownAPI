require 'spec_helper'

describe EntryAudits do

  # TODO Fix conditions being added on with versioning properly

  let(:target_date) { Date.parse("Aug-13-2014").to_datetime.beginning_of_day }
  let!(:user) { create :user, created_at: 10.years.ago }
  let!(:entry) { build :entry, user_id: user.id.to_s, date: target_date.to_date }

  before(:each) do
    date = target_date - 10.days

    # Do some version stuffs, setup a history
    Timecop.travel(date)          # now Aug 3
    # === #
    ActiveRecord::Base.transaction do
      user.catalogs             << "hbi"
      user.user_conditions.activate   create(:condition, name: "allergies")
      user.user_symptoms.activate     create(:symptom, name: "runny nose")
      user.user_symptoms.activate     create(:symptom, name: "itchy throat")
    end

    Timecop.travel(date+1.days)   # now Aug 4
    # === #
    ActiveRecord::Base.transaction do
      user.user_treatments.activate   create(:treatment, name: "loratadine", quantity: 10.0, unit: "mg")
    end

    Timecop.travel(date+9.days)   # now Aug 12
    # === #
    ActiveRecord::Base.transaction do
      user.user_conditions.activate   create(:condition,name: "back pain")
      user.user_treatments.activate   create(:treatment, name: "sinus rinse", quantity: 1.0, unit: "session")
    end

    # --- Target Date for Entry --- #

    Timecop.travel(date+11.days)  # now Aug 14
    # === #
    ActiveRecord::Base.transaction do
      user.catalogs             << "rapid3"
      user.user_conditions.activate   create(:condition,name: "ticklishness")
      user.user_conditions.deactivate Condition.find_by(name: "back pain")
      user.user_treatments.activate   create(:treatment, name: "advil", quantity: 2.0, unit: "pill")
      user.user_symptoms.deactivate   Symptom.find_by(name: "itchy throat")
    end

    Timecop.return
  end

  describe "#applicable_audit" do
    it "gets the applicable audit version", versioning: true do
      expect(PaperTrail).to be_enabled

      audit = entry.applicable_audit # Get version closest (looking pastwards) to the target entry

      expect(audit.reify(has_many: true).current_conditions.map(&:name)).to include("back pain")
      expect(audit.reify(has_many: true).current_treatments.map(&:name)).to_not include("advil") # only in most recent
    end

    it "gets current version of user when no future version exists", versioning: true do
      entry.date = Date.today
      audit = entry.applicable_audit

      expect(audit).to eql false
    end

  end

  describe "#set_user_audit_version!" do
    it "adds to the entry based on audit contents", versioning: true do
      entry.set_user_audit_version!

      expect(entry).to be_an Entry
      expect(entry.conditions).to eql %w( allergies back\ pain )
      expect(entry.treatments.map(&:name)).to eql %w( loratadine sinus\ rinse )
      expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose itchy\ throat )
    end

    it "matches live version when no version is set", versioning: true do
      entry.date = Date.today
      entry.set_user_audit_version!

      expect(entry.conditions).to eql %w( allergies ticklishness )
      expect(entry.treatments.map(&:name)).to eql %w( loratadine sinus\ rinse advil )
      expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose )
    end
  end


end
