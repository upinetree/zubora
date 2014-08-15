FactoryGirl.define do
  factory :user do
    sequence(:screen_name) { |n| "screen_name#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password "password1"
    password_confirmation "password1"
  end
end
