require 'spec_helper'

class FakeCatalog
  SCORE_COMPONENTS = %i( foo bar )
end
class FakeEntry
  include CatalogScore

  # Entries always have the following attributes
  def user_id; 1; end
  def date; Date.today; end
  # def scores; [Hashie::Mash.new({name: "fake", value: nil})]; end
  def scores; [Score.new({name: "fake", value: nil})]; end

  def valid_fake_entry?; true ;end
  def complete_fake_entry?; true ;end
  def fake_score_components; %w( foo bar ) ;end
  def fake_foo_score; 15; end
  def fake_bar_score; 20; end
end

describe CatalogScore do
  let(:entry) { FakeEntry.new() }

  it "#calculate_score" do
    entry.instance_variable_set(:@catalog, "fake")
    result = entry.calculate_score

    expect(result).to be_an Array
    expect(result).to have(2).items
    expect(result[0]).to eql 35
    expect(result[1]).to be_an Array
  end
  it "#calculate_score_components" do
    entry.instance_variable_set(:@catalog, "fake")
    scores = entry.calculate_score_components

    expect(scores).to_not be_nil
    expect(scores).to be_an Array
    expect(scores.first).to be_an Hash
    expect(entry.calculate_score_components.first[:name]).to eql "foo"
    expect(entry.calculate_score_components.first[:score]).to eql 15
  end

  it "#save_score" do
    entry.save_score("fake")
    expect(REDIS.get("1:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:fake_score")).to eq "35"
    expect(REDIS.hget("1:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:fake", "foo")).to eq "15"
  end

  describe "with HBI catalog" do
    let(:user) { create :user }
    let!(:entry) { with_resque{ create :hbi_entry, user: user } }

    it "#save_score" do
      total_score     = REDIS.get("#{user.id}:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:hbi_score")
      component_score = REDIS.hget("#{user.id}:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:hbi", "stools")

      expect(total_score).to be_present
      expect(component_score).to be_present

      expect(total_score.to_i).to be_an Integer
      expect(component_score.to_i).to be_an Integer
    end
    it "saves the score on the entry document" do
      expect(entry.reload.scores).to have(2).items # hbi + symptoms
    end
  end

  describe "with symptoms catalog" do
    let!(:user) do
      u=create :user
      ["droopy lips", "fat toes", "slippery tongue"].each do |name|
        u.user_symptoms.activate u.symptoms.create name: name, locale: "en"
      end
      u
    end
    let!(:entry) { with_resque{ create :symptom_entry, user: user } }

    it "#save_score" do
      total_score     = REDIS.get("#{user.id}:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:symptoms_score")
      component_score = REDIS.hget("#{user.id}:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:symptoms", "droopy lips")

      expect(total_score).to be_present
      expect(component_score).to be_present

      expect(total_score.to_i).to be_an Integer
      expect(component_score.to_i).to be_an Integer
    end

    it "saves the score on the entry document" do
      expect(entry.reload.scores).to have(1).item # just symptoms
    end

    it "calculates scores for any responses in the 'symptoms' catalog" do
      entry.responses << {catalog: "symptoms", name: "unibrow" , value: 2}
      user.user_symptoms.activate user.symptoms.create name: "unibrow", locale: "en"

      with_resque{ entry.save; Entry.perform(entry.id) }

      unibrow_score = REDIS.hget("#{user.id}:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:symptoms", "unibrow")
      expect(unibrow_score).to eql "2.0"
    end

    it "ignores nil scores" do
      entry.responses << {catalog: "symptoms", name: "unibrow" , value: 2}
      entry.responses << {catalog: "symptoms", name: "buckteeth" , value: nil}
      user.user_symptoms.activate user.symptoms.create name: "unibrow", locale: "en"
      user.user_symptoms.activate user.symptoms.create name: "buckteeth", locale: "en"

      with_resque{ entry.save; Entry.perform(entry.id) }

      buckteeth_score = REDIS.hget("#{user.id}:scores:#{entry.date.to_time.utc.beginning_of_day.to_i}:symptoms", "buckteeth")
      expect(buckteeth_score).to eql nil
    end

  end

end
