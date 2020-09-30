FactoryBot.define do
  factory :like do
    association :post, factory: :post
    user { post.user }
  end
end
