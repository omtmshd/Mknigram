FactoryBot.define do
  factory :user do
    name                  { 'test_user' }
    email                 { 'test@gmail.com' }
    password              { '00000000' }
    password_confirmation { '00000000' }
  end

  factory :sub_user, class: User do
    name                  { 'sub_user' }
    email                 { 'sub@gmail.com' }
    password              { '00000000' }
    password_confirmation { '00000000' }
  end

  factory :n_user, class: User do
    name                  { 'n_user' }
    sequence(:email)      { |n| "test#{n}@gmail.com"}
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

  trait :with_list_folders do
    transient do
      list_folders_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:list_folder, evaluator.list_folders_count, user: user)
    end
  end

  trait :with_likes do
    transient do
      likes_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:like, evaluator.likes_count, user: user)
    end
  end
end
