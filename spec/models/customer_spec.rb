require 'rails_helper'
include OauthStub

RSpec.describe Customer, :type => :model do
  
  it { should validate_uniqueness_of :email }
  it { should have_many :orders }
  it { should have_many :ratings }
  it { should have_one :billing_address }
  it { should have_one :shipping_address }
  it { should have_one :credit_card }
  it { should accept_nested_attributes_for :billing_address }
  it { should accept_nested_attributes_for :shipping_address }

  context '.from_omniauth' do
    let(:customer) {FactoryGirl.create(:customer)}

    it 'returns customer' do
      expect(Customer.from_omniauth(set_omniauth)).to be_instance_of(Customer)
    end

    it 'creates new customer' do
      expect(Customer.from_omniauth(set_omniauth(uid: '1222'))).not_to eq customer
    end

    it 'takes existed customer' do
      expect(Customer.from_omniauth(set_omniauth(uid: customer.uid, info: {email: customer.email} ))).to eq customer
    end
  end
end
