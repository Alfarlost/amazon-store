FactoryGirl.define do
  factory :book do
    title "MyString"
description "MyText"
price 1
bookinstock 1
category_id rand(3)
  end
end
