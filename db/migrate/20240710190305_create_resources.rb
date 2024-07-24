class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.references :account, index: true
      t.string :name, null: false
      t.integer :max_capacity, default: 0
      t.timestamps
    end
  end
end
