class ApplicationController < ActionController::Base
  include BootstrapFlashHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale
  helper_method :current_order

  def current_order
    if session[:order_id].present?
      order = Order.find(session[:order_id])
      if order.state != "in progress" 
        order = Order.build_for_customer(current_customer)
        session[:order_id] = order.id
      end
    else
      order = Order.build_for_customer(current_customer)
      session[:order_id] = order.id
    end
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
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :current_password, :billing_address => {}, :shipping_address => {})}
  end

  def default_url_options(options = {})
    {:locale => I18n.locale}
  end

end
