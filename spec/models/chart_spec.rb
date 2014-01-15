require 'spec_helper'

describe "Chart" do
  describe "#score_coordinates" do
    let(:user) { create :user }
    before(:each) do
      3.times do
        create :cdai_entry, user: user
        # with_resque {entry}
      end
    end
    
    let(:coordinates) { user.cdai_score_coordinates }
    it "should return coordinates" do
      expect(coordinates.count).to eq 3
      expect(coordinates.first).to have_key(:x)
      expect(coordinates.first).to have_key(:y)
    end
    
    it "should return unix time and score for x and y" do
      expect(DateTime.strptime(coordinates.first[:x].to_s, "%s")).to be_a DateTime
      expect(coordinates.first[:y]).to be_an Integer
    end
        
  end
end
