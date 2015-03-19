FactoryGirl.define do
  factory :category do
    sequence(:title) {|n| "Title#{n}"}

    factory :category_list do
      after(:create) do |category|
        create_list(:book, 2, category: category)
      end
    end
  end
end
