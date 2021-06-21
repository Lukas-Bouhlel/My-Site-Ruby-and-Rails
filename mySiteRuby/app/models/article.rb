class Article < ApplicationRecord

    belongs_to :user, foreign_key: "users_id"

end