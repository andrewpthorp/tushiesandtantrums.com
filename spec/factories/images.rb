# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    file { File.open(Dir.glob(File.join(Rails.root, 'lib', 'assets', 'images', 'products', '*')).sample) }

    factory :primary_image do
      primary true
    end
  end
end
