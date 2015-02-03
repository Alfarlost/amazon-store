class CartsController < ApplicationController
  def show
  	@orderitems = current_order.orderitems
  end
end
