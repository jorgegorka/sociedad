class CreateScheduleCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :schedule_categories do |t|
      t.references :account
      t.string :name, null: false
      t.string :icon
      t.string :colour
      t.timestamps
    end
  end
end
