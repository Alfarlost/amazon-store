require 'rails_helper'

RSpec.describe Orderitem, :type => :model do
  let(:orderitem) {FactoryGirl.build :orderitem}
  let(:order) {FactoryGirl.create :order}

  context "save orderitem" do
    it "finalize before save" do
      orderitem.save
      expect(orderitem).to receive(:finalize)
    end
    
  end
end
