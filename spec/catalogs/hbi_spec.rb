require 'spec_helper'

describe HbiCatalog do
  describe "#score" do
    let(:user) { create :user }

    describe "General" do
      let!(:entry) { create :hbi_entry }

      it "should have a score queue in resque" do
        expect(Entry).to have_queue_size_of(1)
      end

      it "should validate responses" do
        # Range
        range_response = entry.responses.detect{|q| q.name == "stools"}
        range_response.value = 999
        expect(entry).to be_invalid
        range_response.value = 1
        expect(entry).to be_valid

        # Nils
        range_response.value = nil
        expect(entry).to be_valid

        # Boolean
        boolean_response = entry.responses.detect{|q| q.name == "complication_abscess"}
        boolean_response.value = 2
        expect(entry).to be_invalid
        boolean_response.value = 1
        expect(entry).to be_valid
      end

      it "isn't complete if nils responses are present" do
        response = entry.responses.detect{|q| q.name == "stools"}
        response.value = nil
        expect(entry.complete_hbi_entry?).to be_false
      end
    end

    describe "Scoring" do
      let(:entry) { create :hbi_entry, user: user }
      it "has a score if all responses are present" do
        expect(entry.responses.count).to eq HbiCatalog::QUESTIONS.count
        expect(entry.hbi_score).to be > 0
      end

      it "reverts to -1 (incomplete) if any responses are removed" do
        entry.responses.delete entry.responses.first
        with_resque{ entry.save }; entry.reload

        expect(entry.responses.count).to be < HbiCatalog::QUESTIONS.count
        expect(entry.reload.hbi_score).to eql -1.0
      end
    end

    describe "Calculations" do
      let(:entry) { build :hbi_entry, user: user }
      it "sample entry scores match calculated scores" do
        entry.responses << build(:response, {catalog: "hbi", name: :general_wellbeing , value: 1})
        entry.responses << build(:response, {catalog: "hbi", name: :ab_pain           , value: 2})
        entry.responses << build(:response, {catalog: "hbi", name: :stools            , value: 3})
        entry.responses << build(:response, {catalog: "hbi", name: :ab_mass           , value: 0})

        entry.responses << build(:response, {catalog: "hbi", name: :complication_arthralgia       , value: 0})
        entry.responses << build(:response, {catalog: "hbi", name: :complication_uveitis          , value: 0})
        entry.responses << build(:response, {catalog: "hbi", name: :complication_erythema_nodosum , value: 0})
        entry.responses << build(:response, {catalog: "hbi", name: :complication_aphthous_ulcers  , value: 1})
        entry.responses << build(:response, {catalog: "hbi", name: :complication_anal_fissure     , value: 0})
        entry.responses << build(:response, {catalog: "hbi", name: :complication_fistula          , value: 0})
        entry.responses << build(:response, {catalog: "hbi", name: :complication_abscess          , value: 1})

        entry.save
        Entry.perform entry.id, false
        entry.reload

        expect(entry.hbi_complications_score).to eql 2.0
        expect(entry.hbi_score).to eql               8.0
      end
    end


  end
end
