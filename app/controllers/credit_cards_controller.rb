class CreditCardsController < ApplicationController
  def new
    if current_order.credit_card.persisted?
      redirect_to order_url(current_order.id)
    else
      @credit_card = current_order.build_credit_card
    end
  end

  def create
    @credit_card = current_order.build_credit_card(credit_card_params)
    @credit_card.firstname = current_order.billing_address.first_name
    @credit_card.lastname = current_order.billing_address.last_name
    if @credit_card.save
      redirect_to order_url(current_order.id)
    else
      redirect_to :back, notice: "Something is wrong. Check your credit card information."
    end
  end

  def edit
    @credit_card = CreditCard.find(params[:id])
  end

  def update
    @credit_card = CreditCard.find(params[:id])
    if @credit_card.update_attributes(credit_card_params)
      redirect_to order_url(current_order.id)
    else 
      redirect_to :back, notice: @credit_card.errors.first
    end
  end

private
  def credit_card_params
    params.require(:credit_card).permit(:number, :cvv, :expiration_month, :expiration_year, :firstname, :lastname)
  end
end
