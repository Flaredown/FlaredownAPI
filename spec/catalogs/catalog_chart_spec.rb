require 'spec_helper'

describe CatalogChart do
  let(:user) { create :user }
  let(:chart) { CatalogChart.new(user.id, "hbi") }
  
  it "#date_range" do
    range = chart.date_range(Date.today, Date.today+3.days)
    expect(range).to have(4).items
    expect(Time.at(range.first).to_date).to eql Date.today
  end
  
  describe "#score_coordinates" do
    let(:user) { create :user }
    before(:each) do
      3.times do |i|
        create :hbi_entry, user: user, date: Date.today-i.days
      end
    end
    
    let(:chart) { CatalogChart.new(user.id, ["hbi"]) } # default date span, 1 week before
    
    describe "#data" do
      let(:data) { chart.catalogs_data }
      it "should return a hash with keys for various chart pieces" do
        expect(data).to be_a Array
        
        expect(data.first).to have_key(:name)
        expect(data.first[:name]).to eq "hbi"
        
        expect(data.first).to have_key(:scores)
        expect(data.first).to have_key(:components)
        # expect(data.first).to have_key(:medications)
      end
    end
    
    describe "#score_coordinates" do
      
      let(:coordinates) { chart.score_coordinates("hbi") }
      it "should have x values sorted chronologically" do
        Timecop.freeze do
          oldest_entry = with_resque{ create :hbi_entry, user: user, date: Date.today-6.days }
          expect(chart.score_coordinates("hbi").count).to eq 4
          expect(Time.at(chart.score_coordinates("hbi").first[:x]).to_date).to eq oldest_entry.date
        end
      end
      it "should return coordinates" do
        expect(coordinates.count).to eq 3
        expect(coordinates.first).to have_key(:x)
        expect(coordinates.first).to have_key(:y)
      end
    
      it "strips entries without scores from coordinates" do
        pending "This shouldn't be possible due to incomplete catalogs going to -1"
        entry = Entry.by_date(key: Time.at(coordinates.first[:x]).to_date).first
        entry.responses.delete entry.responses.first
        entry.scores.first.write_attribute "value", nil
        with_resque{ entry.save }; entry.reload
        expect(CatalogChart.new(user.id, "hbi").score_coordinates("hbi").count).to eq 2
      end
    
      it "should return unix time and score for x and y" do
        expect(DateTime.strptime(coordinates.first[:x].to_s, "%s")).to be_a DateTime
        expect(coordinates.first[:y]).to be_an Integer
      end
    end
    
    it "should return a limit chart for a limited date range" do
      expect(chart.score_coordinates("hbi", Date.yesterday, Date.today).count).to eq 2
    end
        
  end
  

end
