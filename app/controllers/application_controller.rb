class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale
  helper_method :current_order

  def current_order
    if customer_signed_in?
      order = set_customer
      customer_billing_address = current_customer.billing_address
      customer_shipping_address = current_customer.shipping_address
      customer_credit_card = current_customer.credit_card
      order.billing_address = customer_billing_address
      order.shipping_address = customer_shipping_address
      order.credit_card = customer_credit_card
      order.save
      return order
    else  
      set_order
    end
  end

private
  def set_customer
    order = set_order
    order.customer_id = session[:customer_id]
    order.save
    return order 
  end

  def set_order
    if session[:order_id].present?
      order = Order.find(session[:order_id])
      unless order.state == "in progress"
      order = Order.create
      end
    else
      order = Order.create
    end
    session[:order_id] = order.id
    return order
  end

protected 
  def set_locale
    if params[:locale].blank?
      I18n.locale = :'en'
    else
      I18n.locale = params[:locale]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password, :billing_address => {}, :shipping_address => {}, :credit_card => {})}
  end

  def default_url_options(options = {})
    {:locale => I18n.locale}
  end

end
