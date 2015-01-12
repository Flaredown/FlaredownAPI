require 'spec_helper'

describe Colorable do
  describe "#colors_for returns an array of active colors / hex values pairs" do

    let(:object) { Object.new.extend(Colorable) }

    let(:colorables) do
      [
        {name: "symptom_droopy lips",       date: DateTime.parse("Aug-14-2014"), active: true},
        {name: "symptom_pointy eyelashes",  date: DateTime.parse("Aug-13-2014"), active: true},
        {name: "symptom_slippery tongue",   date: DateTime.parse("Aug-12-2014"), active: true},
        {name: "symptom_fat toes",          date: DateTime.parse("Aug-13-1986"), active: false},
      ]
    end
    let(:palette) { Colorable::PALETTES[:pastel] }

    it "orders color assignments by date" do
      results = object.colors_for(colorables)
      expect(results).to be_an Array

      first = results[0]
      expect(first).to be_an Array
      expect(first[0]).to be_a String
      expect(first[1]).to be_a String
      expect(first[1]).to match /\A#\w{6}\z/

      expect(results).to eql [
        [colorables[2][:name], palette[1]],
        [colorables[1][:name], palette[2]],
        [colorables[0][:name], palette[3]],
      ]
    end

    it "reserves colors for inactive colorables, but doesn't output them" do
      results = object.colors_for(colorables)

      expect(results.length).to eql 3             # only 3 results (out of 4 colorables)
      expect(results.last.last).to eql palette[3] # but 4 color spaces in, due to 1 inactive
    end

    it "works with alternate palette" do
      results = object.colors_for(colorables, palette: :light)

      palette = Colorable::PALETTES[:light]
      expect(results).to eql [
        [colorables[2][:name], palette[1]],
        [colorables[1][:name], palette[2]],
        [colorables[0][:name], palette[3]],
      ]
    end

    it "loops back around when it runs out of palette colors" do
       stub_const("Colorable::PALETTES", { pastel: %w( #F7977A #F9AD81 ) })

       results = object.colors_for(colorables)

       expect(results).to eql [
         [colorables[2][:name], palette[1]],
         [colorables[1][:name], palette[0]],
         [colorables[0][:name], palette[1]],
       ]
    end

    it "raises error on undefined palette" do
      expect(lambda{object.colors_for(colorables, :star_trek)}).to raise "Color palette not found"
    end

  end

end
