require 'spec_helper'

describe EntryTreatment do
  let!(:entry) { create :entry_with_treatments, conditions: ["Crohn's disease"] }
  let(:treatment) { entry.treatments[1] } # second repetition of treatment called "Tickles"

  it "has a long ass uniq string id" do
    expect(treatment.id).to eq "Tickles_1.0_session_2_#{entry.id}"
  end

  it "returns the particular number in time a treatment was taken with #repitition" do
    expect(treatment.repetition).to eq 2
  end

end