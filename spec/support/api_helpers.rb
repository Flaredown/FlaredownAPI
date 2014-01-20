def setup_cdai_questions
  Question.create(name: "ab_pain",        catalog: "cdai", kind: "select", section: 1, group: nil, options: [{value: 0, label: "none", meta_label: "happy_face", helper: nil}, {value: 1, label: "mild", meta_label: "neutral_face", helper: nil}, {value: 2, label: "moderate", meta_label: "frowny_face", helper: nil}, {value: 3, label: "severe", meta_label: "sad_face", helper: nil}])
  Question.create(name: "general",        catalog: "cdai", kind: "select", section: 2, group: nil, options: [{value: 0, label: "well", meta_label: "happy_face", helper: nil}, {value: 1, label: "below_par", meta_label: "neutral_face", helper: nil}, {value: 2, label: "poor", meta_label: "frowny_face", helper: nil}, {value: 3, label: "very_poor", meta_label: "sad_face", helper: nil}, {value: 4, label: "terrible", meta_label: "terrible_face", helper: nil}])
  Question.create(name: "mass",           catalog: "cdai", kind: "select", section: 3, group: nil, options: [{value: 0, label: "none", meta_label: "happy_face", helper: nil}, {value: 3, label: "questionable", meta_label: nil, helper: nil}, {value: 5, label: "present", meta_label: nil, helper: nil}])
  Question.create(name: "stools",         catalog: "cdai", kind: "number", section: 4, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "stools_weekly"}])
  Question.create(name: "hematocrit",     catalog: "cdai", kind: "number", section: 5, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "hematocrit_without_decimal"}])
  Question.create(name: "weight_current", catalog: "cdai", kind: "number", section: 6, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "current_weight"}])
  Question.create(name: "weight_typical", catalog: "cdai", kind: "number", section: 7, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "typical_weight"}])
  Question.create(name: "opiates",                    catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
  Question.create(name: "complication_arthritis",     catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
  Question.create(name: "complication_iritis",        catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
  Question.create(name: "complication_erythema",      catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
  Question.create(name: "complication_fever",         catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
  Question.create(name: "complication_fistula",       catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
  Question.create(name: "complication_other_fistula", catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
end

def api_credentials(user)
  {user_email: user.email, user_token: user.authentication_token}
end
def invalid_credentials(user)
  {user_email: user.email, user_token: "nogood"}
end
def data_is_json
  {'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}
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