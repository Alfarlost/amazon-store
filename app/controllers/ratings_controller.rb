class RatingsController < ApplicationController
  load_and_authorize_resource :book
  load_and_authorize_resource :through => :book

  def new
  end

  def create
    @rating.set_customer(current_customer)
    if @rating.save
      redirect_to book_path(@book.id), notice: "Thank you for your review!"
    else
      flash.now[:notice] = "Please try again."
      render :new
    end
  end

private
  def rating_params
    params.require(:rating).permit(:rating, :review)
  end
end
