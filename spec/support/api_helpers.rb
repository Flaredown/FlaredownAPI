def api_credentials(user)
  {user_email: user.email, user_token: user.authentication_token}
end
def invalid_credentials(user)
  {user_email: user.email, user_token: "nogood"}
end

def login_with_user(user=nil)
  user ||= create :user
  post "/users/sign_in.json", api_credentials(user)
  return user
end

def expect_not_authenticated
  expect(parse_json(response.body)["error"]).to eq "You need to sign in or sign up before continuing."
  returns_code 401
end

# JSON RSpec stuff
def expect_json_is_empty(body)
  expect(body).to be_json_eql ""
end
def returns_code(code)
  expect(response.status).to eq code
end
def json_response
  parse_json(response.body)
end