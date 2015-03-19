FactoryGirl.define do
  factory :customer do
    billing_address
    shipping_address
    sequence(:email) {|n| "customer#{n}@yo.ru"}
    password "zaqwer12"
    password_confirmation "zaqwer12"
    firstname "MyString"
    lastname "MyString"
    uid "1234"
    provider :facebook
  end
end
