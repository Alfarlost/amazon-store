class Checkout
  include Virtus.model

  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_reader :billing_address
  attr_reader :shipping_address
  attr_reader :credit_card
  attr_reader :order

  attribute :b_adress, String
  attribute :b_city, String 
  attribute :b_phone, String 
  attribute :b_country, String 
  attribute :b_zipcode, Integer
  attribute :b_first_name, String
  attribute :b_last_name, String

  attribute :s_adress, String 
  attribute :s_city, String 
  attribute :s_phone, String 
  attribute :s_country, String 
  attribute :s_zipcode, Integer
  attribute :s_first_name, String
  attribute :s_last_name, String

  delegate :number, :cvv, :expiration_month, :expiration_year, to: :credit_card

  def initialize(order)
    @order = order
    if @order.customer.present?
      self.attributes = { :b_adress => @order.billing_address.adress, :b_city => @order.billing_address.city, :b_phone => @order.billing_address.phone, :b_country => @order.billing_address.country, :b_zipcode => @order.billing_address.zipcode, :b_first_name => @order.billing_address.first_name, :b_last_name => @order.billing_address.last_name,
                          :s_adress => @order.shipping_address.adress, :s_city => @order.shipping_address.city, :s_phone => @order.shipping_address.phone, :b_country => @order.shipping_address.country, :b_zipcode => @order.shipping_address.zipcode, :b_first_name => @order.shipping_address.first_name, :b_last_name => @order.shipping_address.last_name }
    end
  end

  def billing_address
    if @order.billing_address.present?
      @billing_address = @order.billing_address
    else
      @billing_address = @order.build_billing_address
    end
    @billing_address
  end

  def shipping_address
    if @order.shipping_address.present?
      @shipping_address = @order.shipping_address
    else
      @shipping_address = @order.build_shipping_address
    end
    @shipping_address
  end

  def credit_card
    if @order.credit_card.present?
      @credit_card = @order.credit_card
    else
      @credit_card = @order.build_credit_card
    end
    @credit_card
  end

  def submit(params)
    credit_card.attributes = params.slice(:number, :cvv, :expiration_month, :expiration_year )
    billing_address.attributes = { :adress => params[:b_adress], :city => params[:b_city], :phone => params[:b_phone], :country => params[:b_country], :zipcode => params[:b_zipcode], :first_name => params[:b_first_name], :last_name => params[:b_last_name] }
    self.same_shipping_address
    credit_card.firstname = params[:b_first_name]
    credit_card.lastname = params[:b_last_name]

    if valid?
      @order.save!
      billing_address.save!
      shipping_address.save!
      credit_card.save!
      true
    else
      false
    end
  end


  def same_shipping_address
    shipping_address.attributes
  end

  def same_shipping_address=(checkbox)
    if checkbox == "true"
      shipping_address.attributes = { :adress => params[:b_adress], :city => params[:b_city], :phone => params[:b_phone], :country => params[:b_country], :zipcode => params[:b_zipcode], :first_name => params[:b_first_name], :last_name => params[:b_last_name] }
    else
      shipping_address.attributes ={ :adress => params[:s_adress], :city => params[:s_city], :phone => params[:s_phone], :country => params[:s_country], :zipcode => params[:s_zipcode], :first_name => params[:s_first_name], :last_name => params[:s_last_name] }   
    end
  end
end
