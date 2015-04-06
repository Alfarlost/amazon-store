class Discount < ActiveRecord::Base
  validates :coupone_code, uniqueness: true
end
