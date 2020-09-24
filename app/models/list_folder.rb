class ListFolder < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  default_scope -> { order(created_at: :desc) }

  belongs_to :user

  has_many :lists, dependent: :destroy
  has_many :listed_posts, through: :lists, source: :post

end
