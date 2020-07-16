class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :post_image, PostImageUploader

  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 250 }
end
