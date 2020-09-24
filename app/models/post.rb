class Post < ApplicationRecord
  validates :post_image, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, length: { maximum: 250 }

  mount_uploader :post_image, PostImageUploader

  default_scope -> { order(created_at: :desc) }

  belongs_to :user

  has_many :post_category, dependent: :destroy
  has_many :categories, through: :post_category

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :lists, dependent: :destroy


end
