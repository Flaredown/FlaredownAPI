require 'spec_helper'

describe Entry do
  let(:entry) { create :entry, catalogs: ["cdai"] }
  
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
  
  describe "#questions" do
    let!(:question) { create :question, :input, {catalog: "cdai"} }
    it "should load questions by catalog" do
      expect(entry.questions).to have(1).items
    end
  end
  
  describe "#responses" do
    let(:entry) { create :cdai_entry }
    it "should have associated question" do
      expect(entry.responses.first.question).to be_a Question
    end
  end
  
  describe "initialization (using CDAI module)" do
    let(:entry) { create :cdai_entry }
    before(:each) do
      with_resque{ entry.save }; entry.reload
    end
    
    it "includes a constant for for catalog score components" do
      expect(Entry::CDAI_SCORE_COMPONENTS).to include :stools
    end
    it "has a list of applicable questions" do
      expect(entry.class.question_names).to include :stools
    end
    it "responds to missing methods by checking if a Question of that name exists" do
      expect(entry.methods).to_not include :stools
      expect(entry.stools).to be_an Integer
    end
    it "responds to missing methods by checking scores for a score in the format 'catalog'_score" do
      expect(entry.methods).to_not include :cdai_score
      expect(entry.cdai_score).to be_an Integer
    end
    it "an actual missing method supers to method_missing" do
      expect{ entry.nosuchmethod }.to raise_error NoMethodError
    end
  end
  
end
