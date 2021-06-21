class AddUserToArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :users, foreign_key: true
  end
end
