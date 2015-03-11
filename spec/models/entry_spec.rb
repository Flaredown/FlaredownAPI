require 'spec_helper'

module FooCatalog
  extend ActiveSupport::Concern

  DEFINITION = {
    general_wellbeing: [{
      name: :general_wellbeing,
      section: 0,
      kind: :select
    }]
  }
  QUESTIONS = DEFINITION.map{|k,v| v}.map{|questions| questions.map{|question| question[:name] }}.flatten
  included do |base_class|
    validate :response_ranges
    def response_ranges
      ranges = [
        [:general_wellbeing, [*99..101]]
      ]
    end
  end
end


describe Entry do
  let(:entry) { create :entry, conditions: ["Crohn's disease"] }

  describe "AVAILABLE_CATALOGS" do
    before(:each) do
      module FooCatalog; def bar; end; end
    end
    it "only accepts known catalogs" do
      entry.catalogs << "foo"
      entry.save
      expect(entry).to_not respond_to :bar

      stub_const("Entry::AVAILABLE_CATALOGS", ["foo"])
      expect(create :entry, catalogs: ["foo"]).to respond_to :bar
    end
  end

  describe "#complete?" do
    let(:entry) { create :hbi_entry }

    it "is complete when all it's catalogs (1 or more) are complete" do
      expect(entry).to be_complete
      entry.responses.delete(entry.responses.first)
      expect(entry).to_not be_complete
    end
  end

  describe "initialization (using HBI module)" do
    let(:entry) { create :hbi_entry }
    before(:each) do
      with_resque{ entry.save }; entry.reload
    end

    # it "includes a constant for for catalog score components" do
    #   expect(Entry::SCORE_COMPONENTS).to include :stools
    # end
    it "responds to missing methods by checking if a Question of that name exists" do
      expect(entry.methods).to_not include :hbi_stools
      expect(entry.hbi_stools).to be_a Float
    end
    it "responds to missing methods by checking scores for a score in the format 'catalog'_score" do
      expect(entry.methods).to_not include :hbi_score
      expect(entry.hbi_score).to be_a Float
    end
    it "an actual missing method supers to method_missing" do
      expect{ entry.nosuchmethod }.to raise_error NoMethodError
    end
  end

  describe "Multiple Catalogs" do
    let(:entry) { create :entry }
    before(:each) do
      stub_const("Entry::AVAILABLE_CATALOGS", ["foo", "hbi"])
    end
    it "prepends question_names with the catalog they belong to" do
      entry.catalogs = ["foo", "hbi"]
      # respond_to? doesn't work with method_missing. Implementing respond_to? causes problems with CouchRest...
      expect{entry.foo_general_wellbeing}.not_to raise_error
      expect{entry.hbi_general_wellbeing}.not_to raise_error
    end
  end

  describe "Condition (Illness) Severity Questions" do
    let!(:entry) { create :entry}

    it "has a generic question for each condition in the catalog definition" do
      entry.conditions = ["Crohn's disease"]

      conditions = entry.catalog_definitions[:conditions]
      expect(conditions).to be_an Array
      expect(conditions.first).to be_an Array
      expect(conditions.first.first[:name]).to eql "Crohn's disease"
    end

    it "it works with multiple, they go into the same section" do
      entry.conditions = ["Allergies", "Crohn's disease"]

      conditions = entry.catalog_definitions[:conditions]
      expect(conditions.first.first[:name]).to eql "Allergies"
      expect(conditions.first.last[:name]).to eql "Allergies"
    end
  end

  describe "Response processing" do
    let(:responses_for_hbi) { [
        { catalog: "hbi", name: "general_wellbeing", value: 4 }
    ] }
    let(:responses_for_hbi_and_symptoms) { [
        { catalog: "hbi", name: "general_wellbeing", value: 4 },
        { catalog: "symptoms", name: "droopy lips", value: 3 },
        { catalog: "symptoms", name: "fat toes", value: 2 },
        { catalog: "conditions", name: "Crohn's disease", value: 2 }
    ] }

    let(:entry) { create :entry }
    it "sets catalogs based on the responses" do
      expect(entry.catalogs).to eql []

      entry.responses = responses_for_hbi
      entry.process_responses
      expect(entry.catalogs).to eql ["hbi"]

      entry.responses = responses_for_hbi_and_symptoms
      entry.process_responses
      expect(entry.catalogs).to eql ["hbi"]

      entry.responses = []
      entry.process_responses
      expect(entry.catalogs).to eql []
    end

    it "sets conditions based on responses" do
      expect(entry.conditions).to eql []

      entry.responses = responses_for_hbi_and_symptoms
      entry.process_responses
      expect(entry.conditions).to eql ["Crohn's disease"]

      entry.responses = []
      entry.process_responses
      expect(entry.conditions).to eql []
    end

    it "sets symptoms based on responses" do
      expect(entry.symptoms).to eql []

      entry.responses = responses_for_hbi_and_symptoms
      entry.process_responses
      expect(entry.symptoms).to eql ["droopy lips", "fat toes"]

      entry.responses = []
      entry.process_responses
      expect(entry.symptoms).to eql []
    end

  end

end