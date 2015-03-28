class RatingsController < ApplicationController
  before_filter :set_data, :authenticate_customer!

  def new
    @rating = @book.ratings.build
  end

  def create
    @rating = @book.ratings.build(rating_params)
    @rating.set_customer(current_customer)
    if @rating.save
      redirect_to book_path(@book.id), notice: "Thank you for your review!"
    else
      flash.now[:notice] = "Please try again."
      render :new
    end
  end

private
  def set_data
    @book = Book.find(params[:book_id])
  end

  def rating_params
    params.require(:rating).permit(:rating, :review)
  end
end
