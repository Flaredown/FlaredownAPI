require "spec_helper"

describe V1::TreatmentsController, type: :controller do

  let(:user) { create :user }

  before(:each) do
    sign_in(user)
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  context "CREATE" do

    it "creates a treatment if it doesn't already exist" do
      expect(Treatment.count).to eql 0
      post :create, {name: "prednisone"}
      expect(Treatment.count).to eql 1
    end

    it "adds the treatment to the user, adds to treatment_count" do
      post :create, {name: "prednisone"}

      expect(user.reload.treatments_count).to eql 1
      expect(user.treatments.first.name).to eql "prednisone"
    end

    it "returns activated treatment" do
      treatments = [
        {name: "happy gas"},
        {name: "yoga"}
      ]

      treatments.each do |treatment_attrs|
        treatment = create :treatment, treatment_attrs
        user.user_treatments.activate treatment
      end

      post :create, {name: "prednisone"}

      expect(response.body).to be_json_eql({treatment: {id: 1, name: "prednisone"}}.to_json)
    end

    it "doesn't add existing treatment to user twice" do
      treatment = create :treatment, {name: "prednisone"}
      user.user_treatments.activate treatment
      expect(user.reload.active_treatments.length).to eql 1

      post :create, {name: "prednisone"}

      expect(user.reload.treatments.length).to eql 1
      expect(user.active_treatments.length).to eql 1
    end

    it "doesn't create treatment if it already exists" do
      create :treatment, {name: "prednisone"}
      expect(Treatment.first.name).to eql "prednisone"
      expect(Treatment.count).to eql 1

      post :create, name: "prednisone"
      expect(Treatment.count).to eql 1
    end

    it "does not allow name exceeding fifty characters" do
      post :create, {name: "Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam quis"}
      returns_groovy_error(model_name: "treatment", fields: [["name", "100_char_max_length"]], code: 400)
    end

    it "only allows alphanumeric and spaces in name" do
      post :create, name: "hi()$%^&"
      returns_groovy_error(model_name: "treatment", fields: [["name", "only_alphanumeric_hyphens_and_spaces"]], code: 400)
    end

    it "does not allow names with obscene words" do
      post :create, name: "fuck this shit"
      returns_groovy_error(model_name: "treatment", fields: [["name", "no_obscenities"]], code: 400)
    end

  end

  context "SEARCH" do
    let(:other_user) { create :user }

    before(:each) do
      user.user_treatments.activate create(:treatment, name: "predator")
      user.user_treatments.activate create(:treatment, name: "prednisone")
      other_user.user_treatments.activate Treatment.find_by(name: "predator")
      other_user.user_treatments.activate Treatment.find_by(name: "prednisone")
    end

    it "returns an array of results" do
      get :search, name: "pred"
      expect(json_response).to be_an Array
      expect(json_response.first).to be_a Hash
      expect(json_response.count).to eql 2
      expect(json_response.first["name"]).to eql "predator"
      expect(json_response.first["count"]).to eql 2
    end

  end


  context "DESTROY" do
    it "removes the treatment from actives, but keeps it in user.treatments" do
      treatment = create :treatment, {name: "prednisone"}
      user.user_treatments.activate treatment

      delete :destroy, {id: treatment.id}

      returns_success(204)

      expect(user.reload.active_symptoms).to be_empty
      expect(user.treatments.first.name).to eql "prednisone"
    end

    it "returns 404 if not found" do
      delete :destroy, {id: 999}

      returns_groovy_error(name: "404")
    end
  end

end
