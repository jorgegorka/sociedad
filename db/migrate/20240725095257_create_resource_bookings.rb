class CreateResourceBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :resource_bookings do |t|
      t.references :resource, index: true
      t.references :booking, index: true
      t.timestamps
    end
  end
end
