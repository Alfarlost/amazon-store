require 'rails_helper'

RSpec.describe Rating, :type => :model do
  it { should validate_presence_of :review }
  it { should validate_presence_of :rating  }
  it { should belong_to :book }
  it { should belong_to :customer }

  let(:rating) { FactoryGirl.create(:rating) }

  context 'states' do
    describe ':not_approved' do
      it 'should be an initial state' do
        expect(rating).to be_not_approved
      end

      it 'should change to :approved on :approve' do
        rating.approve!
        expect(rating).to be_approved
      end
    end
  end

  context '.rater_name' do
    let(:last_name) { 'Doe' }
    let(:first_name) { 'Jonh' }

    context 'without customer name' do
      before do
        BillingAddress.any_instance.stub(:first_name).and_return nil
        BillingAddress.any_instance.stub(:last_name).and_return nil
      end

      it 'returns Anonimus instead of name' do
        expect(rating.rater_name).to eq 'Anonymous'
      end
    end

    context 'with customer only first name' do
      before do
        BillingAddress.any_instance.stub(:last_name).and_return nil
      end

      it 'returns customer first name from Billing Address' do
        expect(rating.rater_name).to eq first_name
      end
    end

    context 'and last names' do
      it 'returns customer first and last names from Billing Address' do
        expect(rating.rater_name).to eq first_name + ' ' + last_name
      end
    end
  end

  context '.set_customer' do
    let(:customer) { FactoryGirl.create(:customer) }

    it 'sets customer' do
      rating.set_customer(customer)
      expect(rating.customer).to eq customer
    end
  end

end
