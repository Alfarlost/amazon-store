class Order < ActiveRecord::Base
  has_many :orderitems, dependent: :destroy
  has_one :billing_address, class_name: 'BillingAddress', dependent: :destroy
  has_one :shipping_address, class_name: 'ShippingAddress', dependent: :destroy
  has_one :credit_card, dependent: :destroy
  belongs_to :customer
  accepts_nested_attributes_for :orderitems

  include AASM

  aasm :column => 'state' do # default column: aasm_state
    state :in_progress, :initial => true
    state :in_queue
    state :completed
    state :shipped
    state :canceled

    event :to_queue do
      transitions :from => :in_progress, :to => :in_queue
    end

    event :cancel do
      transitions :to => :canceled
    end

    event :complete do
      transitions :from => :in_queue, :to => :completed
    end

    def complete
      completed_data = Time.now
    end
  end

  def update_total_price
    self.total_price_without_discount = recalculate_total_price
    if self.coupone_code.present?
      self.calculate_discount
      self.total_price = self.total_price_with_discount
    else
      self.total_price = self.total_price_without_discount
    end
    self.save
  end

  def calculate_discount
    discount = Discount.find_by(coupone_code: self.coupone_code)
    self.total_price_with_discount = self.total_price_without_discount - self.total_price_without_discount*discount.discount
  end

  def finishable?
    return true if self.billing_address.present? && self.shipping_address.present? && self.delivery.present? && self.credit_card.present?
  end

  def self.build_for_customer(customer)
    if customer.present? && customer.orders.in_progress.present?
      order = customer.orders.in_progress.first
    else
      order = Order.new
      order.save
    end
    order.set_customer(customer) if customer.present?
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
end
