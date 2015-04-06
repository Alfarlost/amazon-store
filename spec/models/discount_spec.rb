require 'rails_helper'

RSpec.describe Discount, :type => :model do
  it { should validate_uniqueness_of :coupone_code }
end
