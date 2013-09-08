FactoryGirl.define do
  factory :product do
    name                { Faker::Commerce.product_name }
    description         { Faker::Lorem.paragraphs(5).join("\n\n") }
    price_in_cents      { rand(1000) * 100 }
    shipping_in_cents   { rand(50) * 100 }
    image               { File.open(Dir.glob(File.join(Rails.root, 'lib', 'assets', 'images', 'products', '*')).sample) }
    tag_list            { ['boys', 'girls', ''].sample }
  end
end
