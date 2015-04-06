require 'rails_helper'

RSpec.describe Orderitem, :type => :model do
  it { should validate_presence_of :quantity }
  it { should validate_numericality_of(:quantity).only_integer(true).greater_than(0) }
  it { should belong_to :order }
  it { should belong_to :book }

  it { is_expected.to callback(:finalize).before(:save) }
  it { is_expected.to callback(:update_order_total_price).after(:save) }
  it { is_expected.to callback(:update_order_total_price).after(:destroy) }


  let(:orderitem) { FactoryGirl.build(:orderitem) }

  context ".calculate_unit_price" do
    it "returns book price if orderitem is not persist" do
      expect(orderitem.calculate_unit_price).to eq orderitem.book.price
    end

    it "returns unit price if orderitem persist" do
      orderitem.save
      expect(orderitem.calculate_unit_price).to eq orderitem.unit_price
    end
  end

  context ".calculate_price" do
    it 'returns orderitem total price' do
      expect(orderitem.calculate_price).to eq orderitem.quantity * orderitem.book.price
    end
  end

  context ".rails_admin_link" do
    it 'returns orderitem book title' do
      expect(orderitem.rails_admin_link).to eq orderitem.book.title
    end
  end

  context '.finalize' do
    before do
      orderitem.send(:finalize)
    end

    it 'saves orderitem price' do
      expect(orderitem.price).to eq orderitem.book.price * orderitem.quantity
    end
    
    it 'saves orderitem unit_price' do
      expect(orderitem.unit_price).to eq orderitem.book.price
    end
  end

  context '.update_order_total_price' do
    it 'updates orderitem order total price' do
      orderitem.send(:finalize)
      orderitem.save
      expect(orderitem.order.total_price).to eq orderitem.price
    end
  end
end
