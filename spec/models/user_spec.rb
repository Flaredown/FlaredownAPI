require 'spec_helper'

describe User do
  let(:user) { create :user }
  it "has an auth token" do
    expect(user.authentication_token).to be_present
  end
end