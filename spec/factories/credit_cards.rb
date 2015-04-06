FactoryGirl.define do
  factory :credit_card do
    order
    number "1234567891234567"
    cvv "987"
    expiration_month 2
    expiration_year 2016
    firstname "MyString"
    lastname "MyString"
  end
end
