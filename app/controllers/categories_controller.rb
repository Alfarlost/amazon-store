class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @books = Book.all
  end

  def show
    @books = @category.books
  end
end
