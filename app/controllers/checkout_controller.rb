class CheckoutController < ApplicationController
  include Wicked::Wizard
  steps *Checkout.form_steps

  before_filter :check_step_access

  def show
    @checkout = Checkout.new(current_order)
    render_wizard
  end

  def update
    @checkout = Checkout.new(current_order)
    if @checkout.update(checkout_params(step))
      jump_to("confirm") if current_order.finishable?
      render_wizard(@checkout)
    else
      flash.now[:alert] = I18n.t('checkout.errors.missing_data')
      render_wizard
    end
  end

private
  def checkout_params(step)
    params[:checkout].merge(form_step: step)
  end

  def redirect_to_finish_wizard(options = nil)
    current_order_id = current_order.id
    current_order.in_queue
    redirect_to order_path(current_order_id), notice: I18n.t('order.state.in_queue')
  end

  def check_step_access
    case step
    when "confirm"
      if current_order.billing_address.blank?
        @step = "adresses" 
        params[:id] = "adresses"
      elsif current_order.delivery.blank?
        @step = "delivery" 
        params[:id] = "delivery"           
      elsif current_order.credit_card.blank? 
        @step = "payment" 
        params[:id] = "payment"
      end
    end
  end
end