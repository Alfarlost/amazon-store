FactoryGirl.define do
  factory :book do
    category
    sequence(:title) {|n| "Book#{n}"}
    description Faker::Lorem.characters(200)
    small_description nil
    price 3
    bookinstock 1

    factory :book_with_orderitems do
      after(:create) do |book|
        create_list(:orderitem, 3, book: book)
      end
    end
  end
end
