# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    sequence(:amount) { |n| 1000 + n }
    accrued_on "2014-01-01"
    user
  end
end
