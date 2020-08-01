class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :filter_by_post, ->(post_id) { where(post_id: post_id) if post_id }
end
