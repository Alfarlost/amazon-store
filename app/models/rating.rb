class Rating < ActiveRecord::Base
  validates :review, presence: true
  ratyrate_rateable "rating"
  belongs_to :customer
  belongs_to :book
end
