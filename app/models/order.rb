class Order < ActiveRecord::Base
  validates :state, inclusion: { in:  ["in progress", "in queue", "complited", "shipped", "canceled"] }

  has_many :orderitems
  has_one :billing_address, class_name: 'BillingAddress', dependent: :destroy
  has_one :shipping_address, class_name: 'ShippingAddress', dependent: :destroy
  has_one :credit_card, dependent: :destroy
  belongs_to :discount
  belongs_to :customer
  before_create :set_discount

  def update_total_price
    self.total_price = recalculate_total_price
    self.save
  end

  def set_discount
    self.discount_id = 1
  end

  def calculate_discount
    self.total_price -= self.total_price*self.discount.discount
    self.save
  end

  def in_queue
    self.state = "in queue"
    self.save
  end

  def self.build_for_customer(customer)
    order = Order.new
    if customer.present?
      order.set_customer(customer)
    end
    order.save
    order
  end

  def set_customer(customer)
    self.billing_address = customer.billing_address.dup
    self.shipping_address = customer.shipping_address.dup
    self.customer = customer
    self.save
  end
  
  def recalculate_total_price
    orderitems.collect { |oi| oi.price }.sum
  end  
end
