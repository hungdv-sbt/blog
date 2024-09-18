class Post < ApplicationRecord

  belongs_to :user, foreign_key: 'id', optional: true
end
