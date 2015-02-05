class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  helper_method :current_order

  def current_order
    if session[:customer_id].present?
      return Order.find(session[:order_id]) if session[:order_id].present?
      order = Order.create
      session[:order_id] = order.id
      order.set_addresses
      order
    else  
  	  return Order.find(session[:order_id]) if session[:order_id].present?
  	  order = Order.create
      session[:order_id] = order.id
      order
    end
  end

protected 

  def set_locale
	  if params[:locale].blank?
	    I18n.locale = :'ru'
	  else
		  I18n.locale = params[:locale]
	  end
  end

  def default_url_options(options = {})
    {:locale => I18n.locale}
  end

end
