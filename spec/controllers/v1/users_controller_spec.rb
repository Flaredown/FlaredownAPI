require "spec_helper"

describe V1::UsersController, type: :controller do

  context "get current_user" do
    let(:user) { create :user }
    before(:each) do
      sign_in(user)
    end

    it "from index action" do
      get :index
      expect(response.body).to be_json_eql CurrentUserSerializer.new(user).to_json
      returns_code 200
    end
    it "from show action" do
      get :show, id: user.id
      expect(response.body).to be_json_eql CurrentUserSerializer.new(user).to_json
      returns_code 200
    end
    it "from show action with bad ID" do
      get :show, id: 999

      returns_groovy_error(name: "404")
    end

  end

  context "setup after onboarded" do
    let(:user) { create :user }
    let(:condition) { create(:condition, name: "allergies") }
    let(:treatment) { create(:treatment, name: "snicker's bar") }
    before(:each) do
      sign_in(user)
      user.user_conditions.activate(condition)
      user.user_treatments.activate(treatment)
    end

    it "sets up an entry for today with trackables" do
      expect(user.entries.count).to eq 0

      put :update, settings: {onboarded: true}

      expect(user.entries.count).to eq 1
      expect(user.entries.first.conditions).to include "allergies"
    end

    # Treatments don't carry over: https://tree.taiga.io/project/lmerriam-flaredown/issue/182
    it "sets up an entry for today with trackables" do
      expect(user.entries.count).to eq 0

      put :update, settings: {onboarded: true}

      expect(user.entries.count).to eq 1
      expect(user.entries.first.treatments.first.name).to eql "snicker's bar"
    end

  end

  context 'get invitee user' do
    let(:invitee) { User.invite!({email: "some_invitee@test.com"}) }

    it 'gets a basic user from invite_token' do
      get "invitee", token: invitee.raw_invitation_token
      expect(response.body).to be_json_eql BasicUserSerializer.new(invitee.reload).to_json
      expect(json_response["invitation_token"]).to eql invitee.raw_invitation_token
      returns_code 200
    end
    it 'receives 404 if token not found' do
      get "invitee", token: "abc123"
      returns_groovy_error(name: "invite_not_found")
    end

  end

end