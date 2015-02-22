class Order < ActiveRecord::Base
  validates :state, inclusion: { in:  ["in progress", "in queue", "complited", "shipped", "canceled"] }

  has_many :orderitems
  has_many :addresses
  has_one :billing_address, class_name: 'BillingAddress'
  has_one :shipping_address, class_name: 'ShippingAddress'
  has_one :credit_card
  belongs_to :customer

  def update_total_price
    self.total_price = recalculate_total_price
    self.save
  end

  def set_shipping_address
    self.shipping_address = self.billing_address if self.billing_address.present?
  end

  def in_queue
    self.state = "in queue"
    self.save
  end

  def self.build_for_customer(customer)
    order = Order.new
    if customer.present?
      order.billing_address = customer.billing_address
      order.shipping_address = customer.shipping_address
      order.credit_card = customer.credit_card
      order.customer = customer
    end
    order.save
    order
  end

  def set_customer(customer)
    self.billing_address = customer.billing_address
    self.shipping_address = customer.shipping_address
    self.credit_card = customer.credit_card
    self.customer = customer
    self.save
  end
  
  private
  def recalculate_total_price
    orderitems.collect { |oi| oi.valid? ? (oi.price) : 0 }.sum
  end  
end
