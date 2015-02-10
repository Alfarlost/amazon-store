class Order < ActiveRecord::Base
  validates :state, inclusion: { in:  ["in progress", "complited", "shipped"] }

  has_many :orderitems
  has_one :billing_address, class_name: 'BillingAddress'
  has_one :shipping_address, class_name: 'ShippingAddress'
  has_one :credit_card  
  belongs_to :customer

  def update_total_price
    self.total_price = recalculate_total_price
    self.save
  end

  def set_addresses
    if self.customer.billing_address.present?
      self.billing_address = self.customer.billing_address
    elsif self.customer.shipping_address.present?
      self.shipping_address = self.customer.shipping_address
    end
      self.save
  end

  def set_shipping_address
    self.shipping_address = self.billing_address if self.billing_address.present?
  end

  
  private
  def recalculate_total_price
    orderitems.collect { |oi| oi.valid? ? (oi.price) : 0 }.sum
  end  
end
