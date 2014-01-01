require "spec_helper"

feature "Login Functions" do
  
  let(:user) { create :user }
  scenario "I login with auth_token" do
    visit root_path(auth_token: user.authentication_token, user_email: user.email)
    # login_email_on_page
  end
  scenario "login with credentials" do
    visit root_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "Login"
    expect(page).to have_content user.email
  end
  scenario "login with invalid credentials" do
    visit root_path
    fill_in "email", with: user.email
    fill_in "password", with: "nope"
    click_on "Login"
    expect(page).to have_content "Invalid email or password"
  end
  
  scenario "logout after logging in" do
    visit root_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "Login"
    expect(page).to have_content user.email
    page.find("#logout").click()
    expect(page).to_not have_content user.email
  end

end