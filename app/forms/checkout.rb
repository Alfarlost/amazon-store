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
  
  def initialize(order)
    @order = order
    @order.build_billing_address if @order.billing_address.nil?
    @order.build_shipping_address if @order.shipping_address.nil?
    @order.build_credit_card if @order.credit_card.nil?

    if required_for_step?(:adresses)
      self.attributes = { :b_adress => @order.billing_address.adress, :b_city => @order.billing_address.city, :b_phone => @order.billing_address.phone, :b_country => @order.billing_address.country, :b_zipcode => @order.billing_address.zipcode, :b_first_name => @order.billing_address.first_name, :b_last_name => @order.billing_address.last_name,
                        :s_adress => @order.shipping_address.adress, :s_city => @order.shipping_address.city, :s_phone => @order.shipping_address.phone, :s_country => @order.shipping_address.country, :s_zipcode => @order.shipping_address.zipcode, :s_first_name => @order.shipping_address.first_name, :s_last_name => @order.shipping_address.last_name } 
    end
    self.attributes = { :delivery => @order.delivery } if required_for_step?(:delivery)
    if required_for_step?(:payment)
      self.attributes = { :number => @order.credit_card.number, :cvv => @order.credit_card.cvv, :expiration_month => @order.credit_card.expiration_month, :expiration_year => @order.credit_card.expiration_year }                   
    end
  end

  def billing_address
    @billing_address = @order.billing_address     
  end

  def shipping_address
    @shipping_address = @order.shipping_address
  end

  def credit_card
    @credit_card = @order.credit_card
  end

  def update(params)
    self.attributes = params
    if valid?
      if required_for_step?(:adresses)
        billing_address.attributes = { :adress => self.b_adress, :city => self.b_city, :phone => self.b_phone, :country => self.b_country, :zipcode => self.b_zipcode, :first_name => self.b_first_name, :last_name => self.b_last_name, :order_id => @order.id, :type => "BillingAddress" }
        if self.same_shipping_address == "false"
          shipping_address.attributes = { :adress => self.s_adress, :city => self.s_city, :phone => self.s_phone, :country => self.s_country, :zipcode => self.s_zipcode, :first_name => self.s_first_name, :last_name => self.s_last_name, :order_id => @order.id, :type => "ShippingAddress" }
        else
          shipping_address.attributes = { :adress => self.b_adress, :city => self.b_city, :phone => self.b_phone, :country => self.b_country, :zipcode => self.b_zipcode, :first_name => self.b_first_name, :last_name => self.b_last_name, :order_id => @order.id, :type => "ShippingAddress" }
        end
        shipping_address.save!
        billing_address.save!
      elsif required_for_step?(:delivery)
        @order.total_price -= @order.delivery if @order.delivery.present?
        @order.delivery = self.delivery
        @order.total_price += @order.delivery
      elsif required_for_step?(:payment)
        credit_card.attributes = self.attributes.slice(:number, :cvv, :expiration_month, :expiration_year)
        credit_card.firstname = billing_address.first_name
        credit_card.lastname = billing_address.last_name
        credit_card.save!
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
  def required_for_step?(step)
    return true if self.form_steps.index(step.to_s) == self.form_steps.index(form_step)
  end
end