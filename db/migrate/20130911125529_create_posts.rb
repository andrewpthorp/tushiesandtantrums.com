class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :slug, index: true, unique: true
      t.boolean :published
      t.timestamps
    end
  end
end
