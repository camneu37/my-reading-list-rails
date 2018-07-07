class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = book
  end

  def new
    @book = Book.new
  end

  def create
    raise params.inspect
  end

  private

    def book
      @book ||= Book.find(params[:id])
    end

end
