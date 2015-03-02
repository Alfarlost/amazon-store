require 'rails_helper'

RSpec.describe Address, :type => :model do
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:adress) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:country) }
  it { should belong_to :order}
  it { should belong_to :customer}
end
