FactoryGirl.define do
  factory :billing_address do
   order_id nil
    adress "Billing"
    zipcode "325235"
    city "MyString"
    phone "MyString"
    country "MyString"
    type "BillingAddress"
    first_name "Jonh" 
    last_name "Doe"
  end
end
