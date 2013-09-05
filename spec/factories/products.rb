FactoryGirl.define do
  factory :product do
    name            { Faker::Commerce.product_name }
    description     { Faker::Lorem.paragraphs(5).join("<br /><br />") }
    price_in_cents  { Faker::Number.number(3) }
    image           { File.open(Dir.glob(File.join(Rails.root, 'lib', 'assets', 'images', 'products', '*')).sample) }
    tag_list        { ['boys', 'girls', ''].sample }
  end
end
