FactoryGirl.define do
  factory :order do
    total_price nil
    completed_data nil
    coupone_code nil
    state "in progress"
    delivery 10

    factory :order_with_orderitem do
      after(:create) do |order|
        create(:orderitem, order: order)
      end
    end
  end
end
