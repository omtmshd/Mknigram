class Category < ApplicationRecord
  has_ancestry
  has_many :post_category
  has_many :posts, through: :post_category
  default_scope -> { order(:id) }
end
