class RemovePasswordAndPasswordConfirmation < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password, :password_confirmation
  end
end
