FactoryGirl.define do
  factory :post do
    title         { Faker::Lorem.sentence(10) }
    body          { Faker::Lorem.paragraphs(5).join("\n\n") }
    published     true

    factory :draft do
      published   false
    end
  end
end
