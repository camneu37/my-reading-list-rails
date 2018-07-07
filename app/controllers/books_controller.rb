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
    binding.pry
  end

  private

    def book
      @book ||= Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author_id, :author, :genre, :about)
    end
    
end
