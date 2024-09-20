class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user, foreign_key: 'user_id', optional: true

  enum status: { draft: 0, publish: 1 }

  scope :publish_post, -> { where(status: 'publish').order(created_at: :desc) }
  scope :eager_load_photos, -> { includes image_attachment: :blob }
  # Ex:- scope :active, -> {where(:active => true)}
end
