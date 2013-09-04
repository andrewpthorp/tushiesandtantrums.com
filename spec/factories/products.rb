FactoryGirl.define do
  factory :product do
    name            { Faker::Commerce.product_name }
    description     { Faker::Lorem.paragraph(5) }
    price_in_cents  { Faker::Number.number(3) }
    image           { File.open(Dir.glob(File.join(Rails.root, 'lib', 'assets', 'images', 'products', '*')).sample) }
  end
end
