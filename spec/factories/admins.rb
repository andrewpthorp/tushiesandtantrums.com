FactoryGirl.define do
  factory :admin do
    email     { Faker::Internet.email }
    password  { 'abc1234' }
  end
end
