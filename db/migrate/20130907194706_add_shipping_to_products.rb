class AddShippingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shipping_in_cents, :integer
  end
end
