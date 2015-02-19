class BooksController < ApplicationController

	def index
      @books = Book.bestsellers(3)
	end

	def show
	  @book = Book.find(params[:id])
	  @orderitem = current_order.orderitems.build
	  @ratings = @book.ratings
	end
end
