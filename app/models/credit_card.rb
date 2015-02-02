class CreditCard < ActiveRecord::Base
  validates :number, :cvv, :expiration_month, :expiration_year, :firstname, :lastname, presence: true

  belongs_to :customer
  has_many :orders
end
