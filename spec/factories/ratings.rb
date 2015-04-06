FactoryGirl.define do
  factory :rating do
    customer
    review "MyText"
    rating 2
  end
end
