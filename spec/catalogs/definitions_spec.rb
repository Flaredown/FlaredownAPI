require 'spec_helper'

describe "Catalog Definitions" do

    it "should have a certain structure" do

      Entry::AVAILABLE_CATALOGS.each do |catalog|
        definition = "#{catalog.capitalize}Catalog".constantize.const_get("DEFINITION")
        expect(definition).to be_a Array
        expect(definition.first).to be_a Array

        question = definition.first.first
        expect(question).to be_a Hash
        expect(question).to have_key :name
        expect(question).to have_key :kind

        expect(question).to_not have_key :section # legacy test
      end

    end

end