class RenameForgetPassword < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :forget_token, :reset_token
    rename_column :users, :forget_expires_at, :reset_expires_at
  end
end
