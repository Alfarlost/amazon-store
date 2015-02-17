class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale
  helper_method :current_order

  def current_order
    if customer_signed_in?
      set_order
      @current_order.set_addresses
    else  
      set_order
    end
    return @current_order
  end
private  
  def set_order
    if session[:order_id].present?
      @current_order = Order.find(session[:order_id])
      if @current_order.state == "in progress"
        @current_order = Order.find(session[:order_id])
      else 
        @current_order = Order.create
      end
    else 
      @current_order = Order.create
    end
    session[:order_id] = @current_order.id
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
    devise_parameter_sanitizer.for(:account_update) {|u|
      u.permit(:email, :password, :password_confirmation, :current_password, :billing_address => {}, :shipping_address => {}, :credit_card => {})
    }
  end

  def default_url_options(options = {})
    {:locale => I18n.locale}
  end

end
