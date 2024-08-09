class AddIndexBookings < ActiveRecord::Migration[7.1]
  def change
    add_index :bookings, %i[user_id schedule_category_id start_on], unique: true 
  end
end
