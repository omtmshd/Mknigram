FactoryBot.define do

  factory :post do
    association :user, factory: :user
    title   { "test_title" }
    body    { "test_body" }
    post_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png')) }
  end
end
