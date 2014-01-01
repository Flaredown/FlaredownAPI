FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@test.com"}
    password "password"
    password_confirmation "password"
  end
end
