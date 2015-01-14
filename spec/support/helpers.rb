def login
  visit root_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_on "Login"
  expect(page).to have_content user.email
end
def register_page
  visit root_path
  click_on "Register Now"
end

def with_versioning
  was_enabled = PaperTrail.enabled?
  was_enabled_for_controller = PaperTrail.enabled_for_controller?
  PaperTrail.enabled = true
  PaperTrail.enabled_for_controller = true
  begin
    yield
  ensure
    PaperTrail.enabled = was_enabled
    PaperTrail.enabled_for_controller = was_enabled_for_controller
  end
end