class BooksController < ApplicationController

	def index
      @books = Book.all
	end

	def show
	  @book = Book.find(params[:id])
	  @orderitem = current_order.orderitems.build
	end
end
