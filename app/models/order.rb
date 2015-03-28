class Order < ActiveRecord::Base
  validates :state, inclusion: { in:  ["in progress", "in queue", "complited", "shipped", "canceled"] }

  has_many :orderitems, dependent: :destroy
  has_one :billing_address, class_name: 'BillingAddress', dependent: :destroy
  has_one :shipping_address, class_name: 'ShippingAddress', dependent: :destroy
  has_one :credit_card, dependent: :destroy
  belongs_to :discount
  belongs_to :customer
  before_save :set_completed_data
  accepts_nested_attributes_for :orderitems

  def update_total_price
    self.total_price = recalculate_total_price
    self.save
  end

  def calculate_discount
    self.total_price -= self.total_price*self.discount.discount
    self.save
  end

  def in_queue
    self.state = "in queue"
    self.save
  end

  def in_progress
    self.state = "in progress"
    self.save
  end

  def cancel
    self.state = "canceled"
    self.save
  end

  def has_valid_coupone_code?
    return true if self.coupone_code == self.discount.coupone_code
  end

  def finishable?
    return true if self.billing_address.present? && self.shipping_address.present? && self.delivery.present? && self.credit_card.present?
  end

  def self.with_state(state)
    where(state: state)
  end

  def self.build_for_customer(customer)
    if customer.present? && customer.orders.with_state("in progress").present?
      order = customer.orders.with_state("in progress").first
    else
      order = Order.new
    end
    order.set_customer(customer) if customer.present?
    order.save
    order
  end

  def set_customer(customer)
    if customer.billing_address.present?
      self.billing_address = customer.billing_address.dup if customer.billing_address.duplicable? && customer.billing_address.valid?  
      self.billing_address.customer_id = nil  
      self.billing_address.save
    end
    if customer.shipping_address.present?
      self.shipping_address = customer.shipping_address.dup if customer.shipping_address.duplicable? && customer.shipping_address.valid?
      self.shipping_address.customer_id = nil
      self.shipping_address.save
    end
    self.customer_id = customer.id
    self.save
  end

  def calculate_books_quantity
    orderitems.collect { |oi| oi.quantity }.sum
  end
  
  def recalculate_total_price
    orderitems.collect { |oi| oi.price }.sum
  end

private
  def set_completed_data
    self.completed_data = Time.now
  end  
end
