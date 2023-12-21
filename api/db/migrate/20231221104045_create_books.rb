class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|

      t.string :title
      t.references :author
      t.string :isbn
      t.integer :genre_id
      t.integer :quantity
      t.float :price
      t.integer :rating
      t.string :image_url

      t.timestamps
    end
  end
end
