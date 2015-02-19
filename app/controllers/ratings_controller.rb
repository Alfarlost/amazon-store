class RatingsController < ApplicationController
  before_filter :set_data
  def new
    @rating = @book.ratings.build
  end

  def create
    @rating = @book.ratings.build(rating_params)
    @rating.customer_id = current_customer.id
    @rating.save
  end

private
  def set_data
    @book = Book.find(params[:book_id])
  end

  def rating_params
    params.require(:rating).permit(:rating, :review)
  end
end
