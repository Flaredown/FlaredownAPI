require 'spec_helper'

describe Entry do
  describe "#score" do
    let(:user) { create :user }
    let!(:entry) { create :entry }
    it "should have a score queue in resque" do
      expect(Entry).to have_queue_size_of(1)
    end
    
    it "calculating score adds to user's chart data" do
      with_resque {entry.calculate_score}
      expect(REDIS.hget("charts:score:#{entry.user.id}", entry.date.to_i.to_s)).to eq entry.score.to_s
    end
    
    
    describe "Scoring" do
      before(:each) do
        10.times { create :entry, user: user}
      end
      it "should have one if there's enough data" do
        expect(Entry.last.score).to be > 0
      end
    end
    
  end
end
