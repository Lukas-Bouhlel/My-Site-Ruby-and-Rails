class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :bio
      t.boolean :image

      t.timestamps
    end
  end
end
