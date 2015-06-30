require 'spec_helper'

describe CatalogGraph do
  let(:user) { create :user }
  let(:chart) { CatalogGraph.new(user.id) }

  before(:each) do
    ["droopy lips", "fat toes", "slippery tongue"].each do |name|
      user.user_symptoms.activate user.symptoms.create name: name, locale: "en"
    end
    ["Crohn's disease", "Depression",].each do |name|
      user.user_conditions.activate user.conditions.create name: name, locale: "en"
    end
    ["Tickles", "Orange Juice",].each do |name|
      user.user_treatments.activate user.treatments.create name: name, locale: "en"
    end
  end

  it "#date_range" do
    range = chart.date_range(Date.today, Date.today+3.days)
    expect(range).to have(4).items
    expect(Time.at(range.first).utc.beginning_of_day.to_date).to eql Date.today
  end

  describe "#score_coordinates" do
    let(:user) { create :user }
    before(:each) do
      3.times do |i|
        create :hbi_and_symptoms_entry, user: user, date: Date.today-i.days
      end
    end

    let(:chart) { CatalogGraph.new(user.id) } # default date span, 1 week before

    describe "#data" do
      let(:data) { chart.catalogs_data }
      it "should return a hash with keys for various catalogs" do
        expect(data).to be_a Hash
        expect(data).to have_key("hbi")
        expect(data).to have_key("symptoms")
        expect(data).to have_key("conditions")
      end
    end

    describe "#score_coordinates for hbi" do

      let(:coordinates) { chart.score_coordinates("hbi") }
      it "should have x values sorted chronologically" do
        Timecop.freeze do
          oldest_entry = with_resque{ create :hbi_and_symptoms_entry, user: user, date: Date.today-6.days }
          expect(chart.score_coordinates("hbi").count).to eq 20
          expect(Time.at(chart.score_coordinates("hbi").first[:x]).utc.beginning_of_day.to_date).to eq oldest_entry.date
        end
      end
      it "should return coordinates" do
        expect(coordinates.count).to eq 15
        expect(coordinates.first).to have_key(:x)
        expect(coordinates.first).to have_key(:order)
      end

      it "should return unix time for x and an order" do
        expect(DateTime.strptime(coordinates.first[:x].to_s, "%s")).to be_a DateTime
        expect(coordinates.first[:order]).to be_an Integer
      end
    end

    it "should return a limit chart for a limited date range" do
      expect(chart.score_coordinates("hbi", Date.today-1.day, Date.today).count).to eq 10
    end

    describe "#score_coordinates for symptoms" do

      let(:coordinates) { chart.score_coordinates("symptoms") }
      it "should return coordinates" do
        expect(coordinates.count).to eq 9 # 3 entries x 3 symptoms
        expect(coordinates.first).to have_key(:x)
        expect(coordinates.first).to have_key(:order)
      end

      it "should return unix time for x and an order" do
        expect(DateTime.strptime(coordinates.first[:x].to_s, "%s")).to be_a DateTime
        expect(coordinates.first[:order]).to be_an Integer
      end
    end

    describe "#score_coordinates for conditions" do

      let(:coordinates) { chart.score_coordinates("conditions") }
      it "should return coordinates" do
        expect(coordinates.count).to eq 6 # 3 entries x 2 conditions
        expect(coordinates.first).to have_key(:x)
        expect(coordinates.first).to have_key(:order)
      end

      it "should return unix time for x and an order" do
        expect(DateTime.strptime(coordinates.first[:x].to_s, "%s")).to be_a DateTime
        expect(coordinates.first[:order]).to be_an Integer
      end
    end

    describe "#score_coordinates for treatments" do

      let(:coordinates) { chart.score_coordinates("treatments") }
      it "should return coordinates" do
        expect(coordinates.count).to be >= 3 # 3 entries w/ at least one treatment each
        expect(coordinates.first).to have_key(:x)
        expect(coordinates.first).to have_key(:order)
        expect(coordinates.first).not_to have_key(:score)
      end

      it "should return unix time for x and an order" do
        expect(DateTime.strptime(coordinates.first[:x].to_s, "%s")).to be_a DateTime
        expect(coordinates.first[:order]).to be_an Integer
      end
    end

  end


end
