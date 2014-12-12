require "spec_helper"

describe V1::EntriesController, type: :controller do

  let(:user) { create :user }
  before(:each) do
    sign_in(user)
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  context "CREATE" do
    it "does not allow name duplicate names" do

    end

    it "does not allow name exceeding fifty charachters" do

    end

    it "only allows alphanumeric and spaces in name" do

    end

    it "does not allow more than eight active symptoms for user" do

    end

    it "does not allow names with obscene words" do
      
    end

  end

  context "SEARCH" do

  end
end
