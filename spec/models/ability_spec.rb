require 'spec_helper'
require "cancan/matchers"

describe 'User' do
  describe 'abilities' do
    context 'when user signed in as admin' do
      let(:admin) { FactoryGirl.create(:admin) }

      subject(:ability) { Ability.new(admin) }

      it { should be_able_to :access, :rails_admin }
      it { should be_able_to :manage, Order.new }
      it { should be_able_to :manage, Book.new }
      it { should be_able_to :manage, Category.new }
      it { should be_able_to :manage, Author.new }
      it { should be_able_to :manage, Country.new }
      it { should be_able_to :manage, Discount.new }
      it { should be_able_to :read, Address.new }
      it { should be_able_to :read, CreditCard.new }
      it { should be_able_to :read, Customer.new }
      it { should be_able_to :read, Rating.new }
      it { should be_able_to :update, Rating.new }
      it { should be_able_to :read, Orderitem.new }
      it { should be_able_to :read, Address.new }
      it { should be_able_to :read, CreditCard.new }
      it { should be_able_to :read, Customer.new }
      it { should be_able_to :read, Rating.new }
      it { should be_able_to :update, Rating.new }
      
      it { should_not be_able_to :manage, Orderitem.new }
      it { should_not be_able_to :manage, Address.new }
      it { should_not be_able_to :manage, CreditCard.new }
      it { should_not be_able_to :manage, Customer.new }
      it { should_not be_able_to :manage, Rating.new }
    end

    context 'when user signed in as customer' do
      let(:customer) { FactoryGirl.create(:customer) }
      let(:order) { FactoryGirl.create(:order_with_orderitem, customer_id: customer.id) }

      subject(:ability) { Ability.new(customer) }

      it { should be_able_to :manage, order }
      it { should be_able_to :manage, Orderitem.new(order_id: order.id) }
      it { should be_able_to :read, Book.new }
      it { should be_able_to :read, Category.new }
      it { should be_able_to :new, Rating.new }
      it { should be_able_to :read, Rating.new }
      it { should be_able_to :create, Rating.new }
      
      it { should_not be_able_to :access, :rails_admin }
      it { should_not be_able_to :manage, Book.new }
      it { should_not be_able_to :destroy, Order.new }
      it { should_not be_able_to :manage, Category.new }
    end

    context "when user isn't signed in" do
      let(:customer) { nil }

      subject(:ability) { Ability.new(customer) }

      it { should be_able_to :manage, Orderitem.new }
      it { should be_able_to :read, Category.new }
      it { should be_able_to :read, Book.new }
      it { should be_able_to :read, Rating.new }
      it { should be_able_to :show, Order.new }
      it { should be_able_to :apply_discount, Order.new }

      it { should_not be_able_to :access, :rails_admin }
      it { should_not be_able_to :manage, Book.new }
      it { should_not be_able_to :manage, Order.new }
      it { should_not be_able_to :manage, Category.new }
      it { should_not be_able_to :manage, Rating.new }
    end
  end
end


