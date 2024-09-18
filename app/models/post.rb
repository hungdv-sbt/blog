class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'id', optional: true

  enum status: %i[draft publish]
  DEFAULT_ITEMS_EACH_PAGE = 10
end
