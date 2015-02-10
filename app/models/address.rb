class Address < ActiveRecord::Base
  validates :adress, :zipcode, :city, :phone, :country, presence: true

  belongs_to :order
  belongs_to :customer
end
