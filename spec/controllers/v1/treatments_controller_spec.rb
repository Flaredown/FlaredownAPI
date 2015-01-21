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

    it "returns array of active_treatments" do
      treatments = [
        {name: "happy gas"},
        {name: "yoga"}
      ]

      treatments.each do |treatment_attrs|
        treatment = create :treatment, treatment_attrs
        user.user_treatments.activate treatment
      end

      post :create, {name: "prednisone"}

      expect(response.body).to be_json_eql({active_treatments: %w( happy\ gas yoga prednisone )}.to_json)
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

    it "does not allow names with obscene words" do
      post :create, name: "fuck this shit"
      error_message = json_response["errors"]["fields"]["name"][0]["message"]
      expect(error_message).to eq "Please do not use obscene words"
      returns_code 400
    end

  end

  context "DESTROY" do
    it "removes the treatment from actives, but keeps it in user.treatments" do
      treatment = create :treatment, {name: "prednisone"}
      user.user_treatments.activate treatment

      delete :destroy, {id: treatment.id}

      expect(response.body).to be_json_eql({success: true}.to_json)
      returns_code 204

      expect(user.reload.active_symptoms).to be_empty
      expect(user.treatments.first.name).to eql "prednisone"
    end

    it "returns 404 if not found" do
      delete :destroy, {id: 999}

      expect(response.body).to be_json_eql({success: false}.to_json)
      returns_code 404
    end
  end

end
