class CreateCustomAttributes < ActiveRecord::Migration[8.0]
  def change
    create_table :custom_attributes do |t|
      t.references :account
      t.string :name, null: false
      t.boolean :block_on_schedule, default: false
      t.timestamps
    end
  end
end
