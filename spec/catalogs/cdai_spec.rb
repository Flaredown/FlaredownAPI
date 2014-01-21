require 'spec_helper'

describe CdaiCatalog do
  describe "#score" do
    let(:user) { create :user }
    let!(:entry) { create :cdai_entry }
    # it "should have a score queue in resque" do
    #   expect(Entry).to have_queue_size_of(1)
    # end
    
    # it "calculating score adds to user's chart data" do
    #   with_resque {entry.calculate_score}
    #   entry.reload
    #   expect(REDIS.hget("charts:cdai_score:#{entry.user.id}", entry.date.to_i.to_s)).to eq entry.score.to_s
    # end
    
    
    describe "Scoring" do
      # before(:each) do
      #   10.times { with_resque{create :cdai_entry, user: user} }
      # end
      let(:entry) { create :cdai_entry, user: user }
      it "has a score if all responses are present" do
        expect(entry.responses.count).to eq Question.where(catalog: "cdai").count
        expect(entry.cdai_score.value).to be > 0
      end
      it "reverts to nil if responses are removed" do
        entry.responses.delete entry.responses.first
        entry.save
        
        expect(entry.responses.count).to be < Question.where(catalog: "cdai").count
        expect(entry.reload.cdai_score.value).to be_nil
      end
    end
    
  end
end
