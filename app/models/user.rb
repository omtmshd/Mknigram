class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_image, ProfileImageUploader

  validates :name, presence: true, length: { maximum: 15 }
  validates :profile, length: { maximum: 150 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  before_validation { email.downcase! }
  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 255 },
            format: {
              with: VALID_EMAIL_REGEX
            }
  has_many :posts, dependent: :destroy
end
