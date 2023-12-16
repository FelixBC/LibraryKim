class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.date :dateEvent
      t.time :timeEvent
      t.timestamp :currentDate
      t.string :description

      t.timestamps
    end
  end
end
