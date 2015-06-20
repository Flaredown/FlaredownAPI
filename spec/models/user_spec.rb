require 'spec_helper'

describe User do
  let(:user) { create :user }
  it "has an auth token" do
    expect(user.authentication_token).to be_present
  end

  describe "catalogs" do
    it "#catalogs returns all catalogs based on all user.conditions" do
      user.user_conditions.activate create(:condition, name: "Crohn's disease")
      expect(user.catalogs).to eql ["hbi"]
    end

    it "#active_catalogs gives only ones for user.active_conditions" do
      user.user_conditions.activate create(:condition, name: "Crohn's disease")
      user.user_conditions.activate create(:condition, name: "Rheumatoid arthritis")
      expect(user.active_catalogs).to eql ["hbi", "rapid3"]

      user.user_conditions.deactivate Condition.find_by(name: "Crohn's disease")
      expect(user.reload.active_catalogs).to eql ["rapid3"]
    end

    it "cannot add duplicate conditions" do
      user.user_conditions.activate create(:condition, name: "Crohn's disease")
      user.user_conditions.activate Condition.find_by(name: "Crohn's disease")
      expect(user.user_conditions.count).to eql 1
    end
  end

  describe "colors" do
    it "#colors" do
      [
        {name: "Tickles", quantity: "1.0", unit: "session"},
        {name: "Laughing Gas", quantity: "10.5", unit: "cc"}
      ].each do |treatment|
        t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
        user.user_treatments.activate t
      end

      # TODO add ones for all trackable types (sanity check)

      first_result = user.trackable_colors
      expect(first_result).to be_an Array
      expect(first_result.first).to be_an Array
      expect(first_result).to have(2).items

      user.user_treatments.deactivate Treatment.first
      expect(user.trackable_colors).to have(2).items
      expect(user.trackable_colors).to eql first_result
    end
  end

  # it "has a scheduled queue for user jobs" do
  #   process_delayed_queue_for_day
  #   expect(User).to have_queue_size_of(1)
  # end
  # it "reschedules the user job upon running it" do
  #   process_delayed_queue_for_day(run:true)
  #   process_delayed_queue_for_day(date: (Date.today+2.days))
  #   expect(User).to have_queue_size_of(1)
  # end
  #
  # describe "#upcoming_catalogs" do
  #   let!(:user) { create :user }
  #   let!(:entry) { create :cdai_entry, user: user }
  #   it "has a list of catalogs approaching their expected use" do
  #     process_delayed_queue_for_day(run: true)
  #     expect(user.upcoming_catalogs).to be_a Array
  #     expect(user.upcoming_catalogs.first[1].to_i).to eql entry.class::CDAI_EXPECTED_USE[-2]
  #   end
  #   it "drops catalog as they move out of expected use range" do
  #     process_delayed_queue_for_day(run:true)
  #     expect(user.upcoming_catalogs.first[1].to_i).to eql entry.class::CDAI_EXPECTED_USE[-2]
  #
  #     8.times do |i|
  #       process_delayed_queue_for_day(date: Date.today+(i+2.days), run:true)
  #     end
  #
  #     expect(user.upcoming_catalogs.first[1].to_i).to be < 0
  #   end
  #   it "creating a new entry for catalog resets upcoming score" do
  #     process_delayed_queue_for_day(run:true)
  #     expect(user.upcoming_catalogs.first[1].to_i).to be < entry.class::CDAI_EXPECTED_USE.last
  #     with_resque{ create :cdai_entry, user: user }
  #     expect(user.upcoming_catalogs.first[1].to_i).to eql entry.class::CDAI_EXPECTED_USE.last
  #   end
  # end

end

def process_delayed_queue_for_day(date: Date.tomorrow.to_time, run: false)
  Timecop.freeze(date + 1.hour) do
    Resque::Scheduler.handle_delayed_items
    ResqueSpec.perform_all(:user) if run
  end
end