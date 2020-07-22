FactoryBot.define do
  factory :user do
    name                  { 'test_user' }
    email                 { 'test@gmail.com' }
    password              { '00000000' }
    password_confirmation { '00000000' }
  end

  trait :with_posts do
    transient do
      posts_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:post, evaluator.posts_count, user: user)
    end
  end
end
