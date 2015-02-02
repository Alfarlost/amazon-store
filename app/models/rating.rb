class Rating < ActiveRecord::Base
  validates :field_name, inclusion: { in:  [1..10] }

  belongs_to :customer
  belongs_to :book
end
