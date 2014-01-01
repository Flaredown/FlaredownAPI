require "spec_helper"
feature "homepage" do
  
  let(:user) { create :user }
  scenario "I arrive on the homepage" do
    login
    expect(page).to have_content "CDAI.me"
  end

end