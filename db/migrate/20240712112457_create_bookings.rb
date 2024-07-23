class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user
      t.references :schedule_category
      t.date :start_on, null: false
      t.date :end_on
      t.timestamps
    end
  end
end
