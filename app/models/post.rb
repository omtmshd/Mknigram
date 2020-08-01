class Post < ApplicationRecord
  belongs_to :user
  has_many :post_category
  has_many :categories, through: :post_category
  has_many :likes, dependent: :destroy

  mount_uploader :post_image, PostImageUploader
  default_scope -> { order(created_at: :desc) }

  validates :post_image, presence: true
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, length: { maximum: 250 }
end
