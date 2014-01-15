require 'spec_helper'

describe Entry do
  describe "AVAILABLE_CATALOGS" do
    let(:entry) { create :entry }
    before(:each) do
      module FooCatalog; def bar; end; end
    end
    it "only accepts known catalogs" do
      entry.catalogs << "foo"
      entry.save
      expect(entry).to_not respond_to :bar
      
      entry.catalogs << "cdai"
      entry.save
      expect(entry).to respond_to :score_cdai_entry
    end
  end
  
  describe "initialization (using CDAI module)" do
    let(:entry) { create :cdai_entry }
    it "responds to CDAI specific methods" do
      expect(entry).to respond_to :score_cdai_entry
    end
    it "has a list of applicable questions" do
      expect(entry.class.question_names).to include :stools
    end
    it "responds to missing methods by checking if a Question of that name exists" do
      expect(entry.methods).to_not include :stools
      expect(entry.stools).to be_an Integer
    end
  end
  
end
