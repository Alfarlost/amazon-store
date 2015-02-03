class Orderitem < ActiveRecord::Base
  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  validate :order_present

  belongs_to :order
  belongs_to :book

  before_save :finalize
  after_save :update_order_total_price

  def calculate_unit_price
  	if persisted?
  	  self.unit_price
  	else
  	  book.price
  	end
  end

  def calculate_price
  	calculate_unit_price * quantity
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
  	self.unit_price = calculate_unit_price
  	self.price = calculate_price
  end

  def update_order_total_price
    self.order.update_total_price
  end
end
