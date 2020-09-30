FactoryBot.define do
  factory :list do
    association :list_folder, factory: :list_folder
    association :post, factory: :post
  end
end
