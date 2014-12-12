require "spec_helper"

describe V1::EntriesController, type: :controller do

  let(:user) { create :user }
  let(:symptom) { create :symptom }
  before(:each) do
    sign_in(user)
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  context "CREATE" do
    it "does not allow name duplicate names" do
      symptom = create :symptom, name: "duplicate"
      post :create, name: "duplicate"
      expect(json_response["errors"]["fields"]["name"][0]["message"]).to eq "Name already exists"
    end

    it "does not allow name exceeding fifty charachters" do
      post :create, name: "longer then ever symptom name that could ever be imagine on this very earth"
      expect(json_response["errors"]["fields"]["name"][0]["message"]).to eq "Name cannot be longer then 50 charachters"
    end

    it "only allows alphanumeric and spaces in name" do
      post :create, name: "hi()$%^&"
      expect(json_response["errors"]["fields"]["name"][0]["message"]).to eq "Name can only include alphanumeric characters and spaces"
    end

    it "does not allow more than eight active symptoms for user" do
      user = create :user, active_symptoms: [1, 2, 3, 4, 5, 6, 7, 8]
      post :create, name: "valid name"
      expect(json_response["errors"]["fields"]["name"][0]["message"]).to eq "You cannot have more than eight symptoms"
    end

    it "does not allow names with obscene words" do
      post :create, name: "fuck this shit"
      expect(json_response["errors"]["fields"]["name"][0]["message"]).to eq "Please do not use obscene words"
    end

  end

  context "SEARCH" do

  end
end
