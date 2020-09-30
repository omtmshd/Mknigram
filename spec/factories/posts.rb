FactoryBot.define do
  factory :post do
    association :user, factory: :user
    title   { 'test_title' }
    body    { 'test_body' }
    post_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png')) }
  end

  trait :with_post_likes do
    transient do
      likes_count { 5 }
    end

    after(:create) do |post, evaluator|
      create_list(:like, evaluator.likes_count, post: post)
    end
  end

  trait :with_post_lists do
    transient do
      lists_count { 5 }
    end

    after(:create) do |post, evaluator|
      create_list(:list, evaluator.lists_count, post: post)
    end
  end
end
