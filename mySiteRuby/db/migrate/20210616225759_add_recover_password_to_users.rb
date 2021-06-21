class AddRecoverPasswordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :recover_password, :string
  end
end
