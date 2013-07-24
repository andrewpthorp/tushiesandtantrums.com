class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text        :description
      t.integer     :price_in_cents
      t.string      :image
      t.timestamps
    end
  end
end
