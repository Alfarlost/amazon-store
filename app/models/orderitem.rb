class Orderitem < ActiveRecord::Base
  validates :price, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  validate :order_present

  belongs_to :order
  belongs_to :book

  before_save :finalize

  def unit_price
  	if persisted?
  	  self[unit_price]
  	else
  	  book.price
  	end
  end

  def price
  	unit_price * quantity
  end

private
  def book_present
  	if book.nil?
  	  errors.add(:book, "is not valid")
  	end
  end

  def order_present
  	if order.nil?
  	  errors.add(:order, "is not valid order")
  	end
  end

  def finalize
  	self[:unit_price] = unit_price
  	self[:price] = price
  end
end
