FactoryGirl.define do
  factory :customer do
    sequence(:email) {|n| "customer#{n}@yo.ru"}
password "zaqwer12"
password_confirmation "zaqwer12"
firstname "MyString"
lastname "MyString"
  end

end
