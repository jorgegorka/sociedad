class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.references :account, index: true
      t.string :name
      t.string :username, null: false
      t.string :email
      t.string :password_digest, null: false
      t.string :forget_token
      t.integer :role, default: 0
      t.datetime :forget_expires_at
      t.timestamps
    end
  end
end
