# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inquiry do
    name    { Faker::Name.name }
    email   { Faker::Internet.email }
    subject { Faker::Lorem.paragraph(3) }
    body    { Faker::Lorem.paragraphs(2).join(' ') }
  end
end
