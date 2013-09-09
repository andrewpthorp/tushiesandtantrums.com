# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :charge do
    stripe_charge_id    { Faker::Lorem.characters(15) }
    email               { Faker::Internet.email }
    name                { Faker::Name.name }
    address_line_1      { Faker::Address.street_address }
    address_line_2      { Faker::Address.secondary_address }
    city                { Faker::Address.city }
    state               { Faker::Address.state_abbr }
    zip                 { Faker::Address.zip }
    status              'ordered'
    product
  end
end
