require "spec_helper"

describe V1::Users::SessionsController, type: :controller do

  context "user login" do
    let(:user) { create :user }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:v1_user]
    end
    it "generates correct error response in case of error" do
      post :create, {v1_user: {email: 'test@test.com'}}
      fields = {
          email: [
              {
                  type: 'invalid',
                  message: 'Email is invalid'
              },
          ],
          password: [
              {
                  type: 'invalid',
                  message: 'Password is invalid'
              },
          ]
      }

      expected_response = {errors: {error_group: 'inline', machine_name: 'validation_error', fields: fields}}
      expect(response.body).to be_json_eql expected_response.to_json
    end
  end



end