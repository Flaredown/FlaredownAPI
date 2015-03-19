require "spec_helper"

describe V1::TagsController, type: :controller do

  let(:user) { create :user }
  let(:other_user) { create :user }

  before(:each) do
    sign_in(user)
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  context "SEARCH" do

    before(:each) do
      user.tag_list.add(%w(abacinate abacination abaciscus abacist aback abactinal abactinally abaction abactor abaculus abacus))
      user.save

      # For Multiplayer
      other_user.tag_list.add("abacinate")
      other_user.save
    end

    it "returns an array of results" do
      get :search, name: "abaci"
      expect(json_response).to be_an Array
      expect(json_response.first).to be_a Hash
      expect(json_response.count).to eql 4

      # Single Player
      expect(json_response.map{|t| t["name"]}).to include "abacinate"
      expect(json_response.first["count"]).to eql 1

      # Multiplayer
      # expect(json_response.map{|t| t["name"]}).to include "abacinate"
      # expect(json_response.first["count"]).to eql 2

    end

  end

end
