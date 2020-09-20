class ListFolder < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }

  belongs_to :user

  has_many :lists, dependent: :destroy
  has_many :listed_posts, through: :lists, source: :posts
end
