class List < ApplicationRecord
  belongs_to :list_folder, -> { includes :user }
  belongs_to :post
end
