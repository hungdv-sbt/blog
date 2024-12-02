class PostComment < ApplicationRecord
  has_one_attached :image

  belongs_to :post, foreign_key: 'post_id', optional: true
  belongs_to :user, foreign_key: 'user_comment_id', optional: true

  scope :eager_load_photos, -> { includes image_attachment: :blob }

end
