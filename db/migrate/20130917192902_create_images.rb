class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string :file
      t.references :product, index: true
      t.timestamps
    end
    remove_column :products, :image
  end

  def down
    drop_table :images
    add_column :products, :image, :string
  end
end
