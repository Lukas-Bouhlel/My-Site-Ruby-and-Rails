class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :motto
      t.string :confirmation_token
      t.string :password_digest
      t.boolean :confirmed, default: false
      t.boolean :avatar, default: false
      
      t.timestamps
    end
  end
end
