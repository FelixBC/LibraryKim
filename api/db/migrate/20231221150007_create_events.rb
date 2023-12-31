class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.date :event_date
      t.string :description
      t.string :image_url
      t.integer :capacity

      t.timestamps
    end
  end
end
