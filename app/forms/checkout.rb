class Checkout
  include Virtus.model

  include ActiveModel::Model

  def persisted?
    false
  end

  cattr_accessor :form_steps do
    %w(adresses delivery payment confirm)
  end

  attr_accessor :form_step

  attr_reader :billing_address
  attr_reader :shipping_address
  attr_reader :credit_card

  attribute :b_adress, String
  attribute :b_city, String 
  attribute :b_phone, String 
  attribute :b_country, String 
  attribute :b_zipcode, Integer
  attribute :b_first_name, String
  attribute :b_last_name, String
  attribute :same_shipping_address, String

  attribute :s_adress, String 
  attribute :s_city, String 
  attribute :s_phone, String 
  attribute :s_country, String 
  attribute :s_zipcode, Integer
  attribute :s_first_name, String
  attribute :s_last_name, String

  attribute :delivery, Integer

  attribute :number, String 
  attribute :cvv, String 
  attribute :expiration_month, Integer
  attribute :expiration_year, Integer

  validates :b_adress, :b_city, :b_phone, :b_country, :b_zipcode, :b_first_name, :b_last_name, presence: true, if: -> { required_for_step?(:adresses) }
  validates :s_adress, :s_city, :s_phone, :s_country, :s_zipcode, :s_first_name, :s_last_name, presence: true, if: -> { required_for_step?(:adresses) }, if: -> { self.same_shipping_address == "false" }
  validates :delivery, presence: true, :numericality => {:greater_than => 0},  if: -> { required_for_step?(:delivery) } 
  validates :number, :cvv, :expiration_month, :expiration_year, presence: true, if: -> { required_for_step?(:payment) }
  validates :number, length: { :is => 16, if: -> { required_for_step?(:payment) } }
  validates :cvv, length: { :is => 3, if: -> { required_for_step?(:payment) } }
  
  def initialize(order)
    @order = order
    @order.build_billing_address if @order.billing_address.nil?
    @order.build_shipping_address if @order.shipping_address.nil?
    @order.build_credit_card if @order.credit_card.nil?

    self.attributes = { :b_adress => @order.billing_address.adress, :b_city => @order.billing_address.city, :b_phone => @order.billing_address.phone, 
                        :b_country => @order.billing_address.country, :b_zipcode => @order.billing_address.zipcode, :b_first_name => @order.billing_address.first_name, 
                        :b_last_name => @order.billing_address.last_name,:s_adress => @order.shipping_address.adress, :s_city => @order.shipping_address.city, 
                        :s_phone => @order.shipping_address.phone, :s_country => @order.shipping_address.country, :s_zipcode => @order.shipping_address.zipcode, 
                        :s_first_name => @order.shipping_address.first_name, :s_last_name => @order.shipping_address.last_name, :delivery => @order.delivery, 
                        :number => @order.credit_card.number, :cvv => @order.credit_card.cvv, :expiration_month => @order.credit_card.expiration_month, 
                        :expiration_year => @order.credit_card.expiration_year }                   
  end

  def update(params)
    self.attributes = params
    if valid?
      if form_step == "adresses"
        set_addresses
      elsif form_step == "delivery"
        set_delivery
      elsif form_step == "payment"
        set_credit_card
      end
      true
    else
      false
    end   
  end
  
  def save
    if valid?
      @order.save!
      true
    else
      false
    end
  end

private
  def set_addresses
    @order.billing_address.attributes = { :adress => self.b_adress, :city => self.b_city, :phone => self.b_phone, :country => self.b_country, 
                                          :zipcode => self.b_zipcode, :first_name => self.b_first_name, :last_name => self.b_last_name, 
                                          :order_id => @order.id, :type => "BillingAddress" }     
    @order.billing_address.save!

    if self.same_shipping_address == "false"
      @order.shipping_address.attributes = { :adress => self.s_adress, :city => self.s_city, :phone => self.s_phone, :country => self.s_country, 
                                             :zipcode => self.s_zipcode, :first_name => self.s_first_name, :last_name => self.s_last_name, 
                                             :order_id => @order.id, :type => "ShippingAddress" }
    else
      @order.shipping_address.attributes = { :adress => self.b_adress, :city => self.b_city, :phone => self.b_phone, :country => self.b_country, 
                                             :zipcode => self.b_zipcode, :first_name => self.b_first_name, :last_name => self.b_last_name, 
                                             :order_id => @order.id, :type => "ShippingAddress" }
    end
    @order.shipping_address.save!
  end

  def set_delivery
    @order.total_price -= @order.delivery if @order.delivery.present?
    @order.delivery = self.delivery
    @order.total_price += @order.delivery
  end

  def set_credit_card
    @order.credit_card.attributes = self.attributes.slice(:number, :cvv, :expiration_month, :expiration_year)
    @order.credit_card.firstname = @order.billing_address.first_name
    @order.credit_card.lastname = @order.billing_address.last_name
    @order.credit_card.save!
  end

  def required_for_step?(step)
    return true if form_step.nil?
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
end