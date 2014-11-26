require 'spec_helper'

describe Rapid3Catalog do
  describe "#score" do
    let(:user) { create :user }
    let!(:entry) { create :rapid3_entry }
    it "should have a score queue in resque" do
      expect(Entry).to have_queue_size_of(1)
    end

    describe "Scoring" do
      let(:entry) { create :rapid3_entry, user: user }
      it "has a score if all responses are present" do
        expect(entry.responses.count).to eq Rapid3Catalog::RAPID3_QUESTIONS.count
        expect(entry.rapid3_score).to be > 0
      end
      it "reverts to -1 (incomplete) if any responses are removed" do
        entry.responses.delete entry.responses.first
        with_resque{ entry.save }; entry.reload

        expect(entry.responses.count).to be < Rapid3Catalog::RAPID3_QUESTIONS.count
        expect(entry.reload.rapid3_score).to eql -1.0
      end

      describe "Calculations" do
        let(:entry) { build :rapid3_entry, user: user }
        it "sample entry scores match calculated scores" do
          entry.responses << build(:response, {name: :dress_yourself        , value: 0})
          entry.responses << build(:response, {name: :get_in_out_of_bed     , value: 1})
          entry.responses << build(:response, {name: :lift_full_glass       , value: 3})
          entry.responses << build(:response, {name: :walk_outdoors         , value: 0})
          entry.responses << build(:response, {name: :wash_and_dry_yourself , value: 0})
          entry.responses << build(:response, {name: :bend_down             , value: 1})
          entry.responses << build(:response, {name: :turn_faucet           , value: 2})
          entry.responses << build(:response, {name: :enter_exit_vehicles   , value: 2})
          entry.responses << build(:response, {name: :walk_two_miles        , value: 1})
          entry.responses << build(:response, {name: :play_sports           , value: 1})

          entry.responses << build(:response, {name: :pain_tolerance        , value: 2.5})
          entry.responses << build(:response, {name: :global_estimate       , value: 1.0})

          entry.save
          Entry.perform entry.id
          entry.reload

          expect(entry.rapid3_functional_status_score).to eql 3.7
          expect(entry.rapid3_pain_tolerance_score).to eql    2.5
          expect(entry.rapid3_global_estimate_score).to eql   1.0
          expect(entry.rapid3_score).to eql                   7.2
        end
      end
    end

  end
end
