require 'spec_helper'

describe User do
  let(:user) { create :user }
  it "has an auth token" do
    expect(user.authentication_token).to be_present
  end
  describe "colors" do
    it "#treatment_colors" do
      [
        {name: "Tickles", quantity: "1.0", unit: "session"},
        {name: "Laughing Gas", quantity: "10.5", unit: "cc"}
      ].each do |treatment|
        t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
        user.activate_treatment t
      end

      first_result = user.treatment_colors
      expect(first_result).to be_an Array
      expect(first_result.first).to be_an Array
      expect(first_result).to have(2).items

      user.deactivate_treatment Treatment.first
      expect(user.treatment_colors).to have(1).item
      expect(user.treatment_colors).to eql first_result[-1..-1]
    end

    it "#symptom_colors" do
      ["droopy lips", "fat toes", "slippery tongue"].each do |name|
        s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
        user.activate_symptom s
      end

      first_result = user.symptom_colors
      expect(first_result).to be_an Array
      expect(first_result.first).to be_an Array
      expect(first_result).to have(3).items

      user.deactivate_symptom Symptom.first
      expect(user.symptom_colors).to have(2).items
      expect(user.symptom_colors).to eql first_result[-2..-1]

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