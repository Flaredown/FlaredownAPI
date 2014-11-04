require 'spec_helper'

describe CdaiCatalog do
  describe "#score" do
    pending "CDAI is not supported yet, due to weekly scoring antics"
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
      # let(:entry) { create :cdai_entry, user: user }
      # before(:each) do
      #   6.times {
      #     another_entry = create :cdai_entry, user: user
      #     with_resque{ another_entry.save }
      #   }
      #   with_resque{ entry.save }; entry.reload
      # end
      #
      # it "has a score if there is at least a week of data" do
      #   pending
      #   first_entry = Entry.by_date.first
      #   expect(first_entry.cdai_score).to eql 0
      #   expect(entry.cdai_score).to be > 0
      # end
      # it "resets all the week scores if any entries from the week are removed/invalidated" do
      #   pending
      # end
      # it "has a score if all responses are present" do
      #   expect(entry.responses.count).to eq Question.where(catalog: "cdai").count
      #   expect(entry.cdai_score).to be > 0
      # end
      # it "reverts to nil if responses are removed" do
      #   entry.responses.delete entry.responses.first
      #   with_resque{ entry.save }; entry.reload
      #
      #   expect(entry.responses.count).to be < Question.where(catalog: "cdai").count
      #   expect(entry.reload.cdai_score).to eql 0
      # end
    end
    
  end
end
