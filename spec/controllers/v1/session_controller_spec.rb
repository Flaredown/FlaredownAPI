require "spec_helper"

describe V1::Users::SessionsController, type: :controller do

  context "user login" do
    let(:user) { create :user }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:v1_user]
    end
    it "generates correct error response in case of error" do
      post :create, {v1_user: {email: 'test@test.com'}}
      returns_groovy_error(name: "bad_credentials")
    end
  end



end
