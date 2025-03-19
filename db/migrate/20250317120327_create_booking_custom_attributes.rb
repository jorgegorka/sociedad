class CreateBookingCustomAttributes < ActiveRecord::Migration[8.0]
  def change
    create_table :booking_custom_attributes do |t|
      t.references :booking
      t.references :custom_attribute
      t.timestamps
    end
  end
end
