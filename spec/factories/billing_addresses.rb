FactoryGirl.define do
  factory :billing_address do
   order
    adress "Billing"
    zipcode "325"
    city "MyString"
    phone "MyString"
    country "MyString"
    type "BillingAddress"
    first_name "Jonh" 
    last_name "Doe"
  end
end
