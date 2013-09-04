# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?

  puts "Destroying #{Product.count.to_s} products..."
  Product.destroy_all
  puts "Done."

  puts "Creating 10 products..."
  10.times do
    product = FactoryGirl.create(:product)
    puts "Created #{product.name}."
  end
  puts "Done."

end
