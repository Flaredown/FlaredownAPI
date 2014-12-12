FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@test.com"}
    password "password"
    password_confirmation "password"
    active_symptoms [1, 2, 3, 4, 5]
    # weight 150
    # gender "male"
  end
end
