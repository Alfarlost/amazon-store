FactoryGirl.define do
  factory :shipping_address do
    order
    adress "Shipping"
    zipcode "325"
    city "MyString"
    phone "MyString"
    country "MyString"
    type "ShippingAddress"
    first_name "Jonh" 
    last_name "Doe"
  end
end
