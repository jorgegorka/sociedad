class AddFullDayAndBlockedNameToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :full_day, :boolean, default: false, null: false
    add_column :bookings, :blocked_name, :string
  end
end
