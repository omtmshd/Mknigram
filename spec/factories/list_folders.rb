FactoryBot.define do
  factory :list_folder do
    association :user, factory: :sub_user
    name {"test_folder"}
  end

  trait :with_lists do
    transient do
      lists_count { 5 }
    end

    after(:create) do |list_folder, evaluator|
      create_list(:list, evaluator.lists_count, list_folder: list_folder)
    end
  end
end
