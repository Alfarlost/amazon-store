class Rating < ActiveRecord::Base
  ratyrate_rateable "rating"
  validates :field_name, inclusion: { in:  [1..10] }

  belongs_to :customer
  belongs_to :book
end
