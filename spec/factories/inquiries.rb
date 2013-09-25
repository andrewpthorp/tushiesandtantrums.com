FactoryGirl.define do
  factory :inquiry do
    name    { Faker::Name.name }
    email   { Faker::Internet.email }
    subject { Faker::Lorem.sentence(5) }
    body    { Faker::Lorem.paragraphs(2).join(' ') }
  end
end
