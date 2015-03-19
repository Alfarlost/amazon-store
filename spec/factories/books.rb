FactoryGirl.define do
  factory :book do
    category
    sequence(:title) {|n| "Book#{n}"}
    description "MyText"
    price 3
    bookinstock 1
  end
end
