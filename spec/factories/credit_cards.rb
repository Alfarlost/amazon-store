FactoryGirl.define do
  factory :credit_card do
    order_id nil
    number "1234567891234567"
    cvv "987"
    expiration_month 1
    expiration_year 1
    firstname "MyString"
    lastname "MyString"
  end
end
