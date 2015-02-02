require 'rails_helper'

RSpec.describe Order, :type => :model do
  let(:order) { FactoryGirl.create :order }

  it "is invalid with bad status" do
    expect(FactoryGirl.build :order, state: "azaza").not_to be_valid
  end

  it "is valid with good status" do
    expect(FactoryGirl.build :order, state: "complited").to be_valid
  end


end
