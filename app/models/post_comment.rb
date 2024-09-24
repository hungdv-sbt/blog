class PostComment < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id', optional: true
  belongs_to :user, foreign_key: 'user_comment_id', optional: true
end
