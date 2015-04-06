require 'rails_helper'

RSpec.describe CreditCard, :type => :model do
  it { should validate_presence_of :number }
  it { should validate_presence_of :cvv }
  it { should validate_presence_of :expiration_month }
  it { should validate_presence_of :expiration_year }

  it { should belong_to :customer }
  it { should belong_to :order }
end
