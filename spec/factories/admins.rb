# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email     { Faker::Internet.email }
    password  { 'abc1234' }
  end
end
