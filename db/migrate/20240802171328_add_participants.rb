class AddParticipants < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :participants, :integer, null: true
  end
end
