class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
      t.timestamp :start_time
      t.timestamp :end_time
      t.text :address
      t.text :city
      t.text :state
      t.text :zip_code
      t.decimal :latitude
      t.decimal :longitude
      t.integer :schedule_id

      t.timestamps
    end
  end
end
