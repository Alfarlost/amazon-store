class CreditCard < ActiveRecord::Base
  validates :number, :cvv, :expiration_month, :expiration_year, presence: true

  belongs_to :customer
  belongs_to :order
end
