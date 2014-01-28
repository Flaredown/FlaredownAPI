require 'spec_helper'

class FakeEntry
  include CatalogScore
  
  FAKE_SCORE_COMPONENTS = %i( foo bar )
    
  # Entries always have the following attributes
  def user_id; 1; end
  def date; Date.today; end
  # def scores; [Hashie::Mash.new({name: "fake", value: nil})]; end
  def scores; [Score.new({name: "fake", value: nil})]; end
  
  def valid_fake_entry?; true ;end
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
    expect(REDIS.get("1:scores:#{entry.date.to_time.to_i}:fake_score")).to eq "35"
    expect(REDIS.hget("1:scores:#{entry.date.to_time.to_i}:fake", "foo")).to eq "15"
  end
  
  describe "with CDAI catalog" do
    let(:user) { create :user }
    let!(:entry) { with_resque{ create :cdai_entry, user: user } }
    
    it "#save_score" do
      expect(REDIS.get("#{user.id}:scores:#{entry.date.to_time.to_i}:cdai_score").to_i).to be > 0
      expect(REDIS.hget("#{user.id}:scores:#{entry.date.to_time.to_i}:cdai", "stools").to_i).to be > 0
    end
    it "saves the score on the entry document" do
      expect(entry.reload.scores).to have(1).item
    end
  end
  
end
