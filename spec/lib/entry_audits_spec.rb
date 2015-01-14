require 'spec_helper'

describe EntryAudits do

  # TODO Fix conditions being added on with versioning properly

  let(:target_date) { Date.parse("Aug-13-2014").to_datetime.beginning_of_day }
  let!(:user) { create :user }
  let!(:entry) { build :entry, user: user, date: target_date.to_date }

  before(:each) do
    date = target_date - 10.days

    # Do some version stuffs, setup a history
    Timecop.freeze(date)
    # === #
    user.save
    user.catalogs             << "hbi"
    user.conditions           << create(:condition, name: "allergies")
    user.activate_symptom     create(:symptom, name: "runny nose")
    user.activate_symptom     create(:symptom, name: "itchy throat")

    Timecop.freeze(date+1.days)
    # === #
    user.activate_treatment   create(:treatment, name: "loratadine", quantity: 10.0, unit: "mg")

    Timecop.freeze(date+9.days) # now Aug 12
    # === #

    user.conditions           << create(:condition,name: "back pain")
    user.activate_treatment   create(:treatment, name: "sinus rinse", quantity: 1.0, unit: "session")

    # --- Target Date Here --- #

    Timecop.freeze(date+11.days) # now Aug 14
    # === #
    user.catalogs             << "rapid3"
    user.conditions           << create(:condition,name: "ticklishness")
    user.conditions           .delete Condition.find_by(name: "back pain")
    user.activate_treatment   create(:treatment, name: "advil", quantity: 2.0, unit: "pill")
    user.deactivate_symptom   Symptom.find_by(name: "itchy throat")

    Timecop.return
  end

  describe "#applicable_audit" do
    it "gets the applicable audit version", versioning: true do
      expect(PaperTrail).to be_enabled

      audit = entry.applicable_audit # Get version closest (looking pastwards) to the target entry

      # expect(audit.reify(has_many: true).conditions.map(&:name)).to include("back pain")
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
      # expect(entry.conditions).to eql %w( allergies back\ pain )
      expect(entry.reload.treatments.map(&:name)).to eql %w( loratadine sinus\ rinse )
      expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose itchy\ throat )
    end

    it "matches live version when no version is set", versioning: true do
      entry.date = Date.today
      entry.set_user_audit_version!

      # expect(entry.conditions).to eql %w( allergies ticklishness )
      expect(entry.reload.treatments.map(&:name)).to eql %w( loratadine sinus\ rinse advil )
      expect(entry.catalog_definitions[:symptoms].flatten.map{|s| s[:name]}).to eql %w( runny\ nose )
    end
  end


end
