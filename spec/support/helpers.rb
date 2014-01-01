def login
  visit root_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_on "Login"
end
def register_page
  visit root_path
  click_on "Register Now"
end