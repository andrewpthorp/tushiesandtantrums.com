# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development? && !ENV['SKIP_PRODUCTS']

  puts "Destroying #{Product.count.to_s} products..."
  Product.destroy_all
  puts "Done."

  puts "Creating 10 products..."
  10.times do
    product = FactoryGirl.create(:product)
    puts "  -> Created #{product.name}."
  end
  puts "Done."

  puts "Destroying #{Charge.count.to_s} charges..."
  Charge.destroy_all
  puts "Done."

  puts "Creating 20 orders..."
  20.times do
    charge = FactoryGirl.create(:charge, product: Product.random.first)
    puts "  -> Created order for #{charge.product.name}."
  end
  puts "Done."

  puts "Shipping 6 orders..."
  6.times do
    Charge.ordered.order('RANDOM()').first.update_column(:status, 'shipped')
  end
  puts "Done."

  puts "Completing 3 orders..."
  3.times do
    Charge.ordered.order('RANDOM()').first.update_column(:status, 'completed')
  end
  puts "Done."

end

unless Admin.any? || ENV['ADMIN_EMAIL'].blank? || ENV['ADMIN_PASS'].blank?
  puts "Creating Admin."
  admin = Admin.new
  admin.email = ENV['ADMIN_EMAIL'].dup
  admin.password = ENV['ADMIN_PASS'].dup
  admin.save!
  puts "Done."
end
