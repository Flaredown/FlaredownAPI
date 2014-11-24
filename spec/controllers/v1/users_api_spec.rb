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
      expect(response.body).to be_json_eql({error: "Not found."}.to_json)
      returns_code 404
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
      expect(response.body).to be_json_eql({error: "Not found."}.to_json)
      returns_code 404
    end

  end

end