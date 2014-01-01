require "spec_helper"
feature "register" do
  
  scenario "register an account" do
    register_page
    fill_in "email", with: "abc@123.com"
    fill_in "password", with: "testing123"
    fill_in "password_confirmation", with: "testing123"
    click_on "Register"
    expect(page).to have_content "abc@123.com"
  end
  scenario "register with a short password" do
    register_page
    fill_in "email", with: "abc@123.com"
    fill_in "password", with: "nope"
    fill_in "password", with: "nope"
    click_on "Register"
    expect(page).to have_content "too short"
  end

end