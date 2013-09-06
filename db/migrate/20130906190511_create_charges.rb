class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string          :stripe_charge_id
      t.string          :name
      t.string          :email
      t.string          :address_line_1
      t.string          :address_line_2
      t.string          :city
      t.string          :state
      t.string          :zip
      t.references      :product
      t.timestamps
    end
  end
end
