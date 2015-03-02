class Order < ActiveRecord::Base
  validates :state, inclusion: { in:  ["in progress", "in queue", "complited", "shipped", "canceled"] }

  has_many :orderitems
  has_many :addresses
  has_one :billing_address, class_name: 'BillingAddress'
  has_one :shipping_address, class_name: 'ShippingAddress'
  has_one :credit_card
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

  def set_shipping_address
    shipping_address = self.build_shipping_address
    shipping_address.adress = self.billing_address.adress
    shipping_address.zipcode = self.billing_address.zipcode
    shipping_address.city = self.billing_address.city
    shipping_address.phone = self.billing_address.phone
    shipping_address.country = self.billing_address.country
    shipping_address.first_name = self.billing_address.first_name
    shipping_address.last_name = self.billing_address.last_name
    self.save
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
    orderitems.collect { |oi| oi.price }.sum
  end  
end
