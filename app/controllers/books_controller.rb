class BooksController < ApplicationController
 load_and_authorize_resource only: :show
  def index
    authorize! :index, Book
    @books = Book.bestsellers(3).accessible_by(current_ability)
  end

  def show
    @orderitem = current_order.orderitems.build
    @ratings = @book.ratings
  end
end
