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
    
    it "should have x values sorted chronologically" do
      Timecop.freeze do
        oldest_entry = create :cdai_entry, user: user, date: Date.today-20.days
        expect(coordinates.count).to eq 4
        expect(Time.from_ms(coordinates.first[:x]).to_date).to eq oldest_entry.date
      end
    end
    it "should return coordinates" do
      expect(coordinates.count).to eq 3
      expect(coordinates.first).to have_key(:x)
      expect(coordinates.first).to have_key(:y)
    end
    
    it "strips entries without scores from coordinates" do
      entry = Entry.find coordinates.first[:entry_id]
      entry.responses.delete entry.responses.first
      entry.scores.first.write_attribute "value", nil
      entry.save

      expect(user.reload.cdai_score_coordinates.count).to eq 2
    end
    
    it "should return unix time and score for x and y" do
      expect(DateTime.strptime(coordinates.first[:x].to_s, "%s")).to be_a DateTime
      expect(coordinates.first[:y]).to be_an Integer
    end
        
  end
end
