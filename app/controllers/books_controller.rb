class BooksController < ApplicationController
 load_and_autorize_resource only: :show
	def index
    @books = Book.bestsellers(3)
	end

	def show
	  @book = Book.find(params[:id])
	  @orderitem = current_order.orderitems.build
	  @ratings = @book.ratings
	end
end
