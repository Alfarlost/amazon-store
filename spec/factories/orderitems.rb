FactoryGirl.define do
  factory :orderitem do
  order
  book
  	price nil
  	unit_price nil
    quantity 2
  end

end
