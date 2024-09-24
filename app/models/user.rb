class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  belongs_to :post_comment, foreign_key: 'user_comment_id'

  validates :name, presence: true
  validates :password, length: { in: 8..32 }
end
