class Address < ActiveRecord::Base
  validates :city, :phone, :adress, :first_name, :last_name, :zipcode, :country, presence: true
  belongs_to :order
  belongs_to :customer
end
