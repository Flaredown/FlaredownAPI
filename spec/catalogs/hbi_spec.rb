require 'spec_helper'

describe HbiCatalog do
  describe "#score" do
    let(:user) { create :user }
    let!(:entry) { create :hbi_entry }
    it "should have a score queue in resque" do
      expect(Entry).to have_queue_size_of(1)
    end
    
    # it "calculating score adds to user's chart data" do
    #   with_resque {entry.save_score("hbi")}
    #   entry.reload
    #   # binding.pry
    #   expect(REDIS.hget("charts:hbi_score:#{entry.user_id}", entry.date.to_time.to_i.to_s)).to eq entry.hbi_score.to_s
    # end
    
    describe "Scoring" do
      let(:entry) { create :hbi_entry, user: user }
      it "has a score if all responses are present" do
        expect(entry.responses.count).to eq HbiCatalog::HBI_QUESTIONS.count
        expect(entry.hbi_score).to be > 0
      end
      it "reverts to -1 (incomplete) if any responses are removed" do
        entry.responses.delete entry.responses.first
        with_resque{ entry.save }; entry.reload

        expect(entry.responses.count).to be < HbiCatalog::HBI_QUESTIONS.count
        expect(entry.reload.hbi_score).to eql -1
      end
    end
    
  end
end
