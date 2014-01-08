require 'spec_helper'

describe Entry do
  describe "#score" do
    let(:user) { create :user }
    
    before(:each) do
      10.times { create :entry, user: user}
    end
    it "should have one if there's enough data" do
      
      expect(Entry.last.score).to be > 0
    end
  end
end
