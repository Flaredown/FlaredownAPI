require "spec_helper"

describe V1::ConditionsController, type: :controller do

  let(:user) { create :user }

  before(:each) do
    sign_in(user)
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  context "CREATE" do

    it "creates a condition if it doesn't already exist" do
      expect(Condition.count).to eql 0
      post :create, {name: "allergies"}
      expect(Condition.count).to eql 1
    end

    it "adds the condition to the user, adds to condition_count" do
      post :create, {name: "allergies"}

      expect(user.reload.conditions_count).to eql 1
      expect(user.conditions.first.name).to eql "allergies"
    end

    it "returns activated condition" do
      conditions = [
        {name: "crohns"},
        {name: "back pain"}
      ]

      conditions.each do |condition_attrs|
        user.user_conditions.activate create(:condition, condition_attrs)
      end

      post :create, {name: "allergies"}

      expect(response.body).to be_json_eql({condition: {id: 1, name: "allergies"}}.to_json)
    end

    it "doesn't add existing condition to user twice" do
      condition = create :condition, {name: "allergies"}
      user.user_conditions.activate condition

      post :create, {name: "allergies"}

      expect(user.reload.conditions.length).to eql 1
    end

    it "doesn't create condition if it already exists" do
      create :condition, {name: "allergies"}
      expect(Condition.first.name).to eql "allergies"
      expect(Condition.count).to eql 1

      post :create, name: "allergies"
      expect(Condition.count).to eql 1
    end

    it "does not allow name exceeding fifty characters" do
      post :create, {name: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis"}
      error_message = json_response["errors"]["fields"]["name"][0]["message"]
      expect(error_message).to eq "Name cannot be longer then 100 charachters"
      returns_code 400
    end

    it "only allows alphanumeric and spaces in name" do
      post :create, name: "hi()$%^&"
      error_message = json_response["errors"]["fields"]["name"][0]["message"]
      expect(error_message).to eq "Name can only include alphanumeric characters, hyphens and spaces"
      returns_code 400
    end

    it "does not allow names with obscene words" do
      post :create, name: "fuck this shit"
      error_message = json_response["errors"]["fields"]["name"][0]["message"]
      expect(error_message).to eq "Please do not use obscene words"
      returns_code 400
    end

  end

  context "SEARCH" do
    let(:other_user) { create :user }

    before(:each) do
      user.user_conditions.activate create(:condition, name: "allergies")
      user.user_conditions.activate create(:condition, name: "bad allergies")
      other_user.user_conditions.activate Condition.find_by(name: "allergies")
      other_user.user_conditions.activate Condition.find_by(name: "bad allergies")
    end

    it "returns an array of results" do
      get :search, name: "allerg"
      expect(json_response).to be_an Array
      expect(json_response.first).to be_a Hash
      expect(json_response.count).to eql 2
      expect(json_response.first["name"]).to eql "allergies"
      expect(json_response.first["count"]).to eql 2
    end

  end

  context "DESTROY" do
    it "removes the condition from actives, but keeps it in user.conditions" do
      condition = create :condition, {name: "allergies"}
      user.user_conditions.activate condition

      delete :destroy, {id: condition.id}

      expect(response.body).to be_json_eql({success: true}.to_json)
      returns_code 204

      expect(user.reload.conditions).to be_empty
    end

    it "returns 404 if not found" do
      delete :destroy, {id: 999}

      expect(response.body).to be_json_eql({success: false}.to_json)
      returns_code 404
    end
  end
end
