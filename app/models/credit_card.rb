class CreditCard < ActiveRecord::Base
  validates :number, :cvv, :expiration_month, :expiration_year, presence: true

  belongs_to :customer
  has_many :orders
end
