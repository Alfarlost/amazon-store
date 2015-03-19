FactoryGirl.define do
  factory :shipping_address do
    order_id nil
    adress "Shipping"
    zipcode "325235"
    city "MyString"
    phone "MyString"
    country "MyString"
    type "ShippingAddress"
    first_name "Jonh" 
    last_name "Doe"
  end
end
