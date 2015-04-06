FactoryGirl.define do
  factory :order do
    total_price nil
    total_price_without_discount nil
    total_price_with_discount nil
    completed_data nil
    coupone_code nil
    state "in_progress"
    delivery 10
    customer_id nil

    factory :order_with_orderitem do
      after(:create) do |order|
        create(:orderitem, order: order)
      end
    end
    factory :order_for_checkout do
      after(:create) do |order|
        create(:billing_address, order: order)
        create(:shipping_address, order: order)
        create(:credit_card, order: order)
      end
    end
  end
end
