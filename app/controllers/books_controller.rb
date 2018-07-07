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
    @book = Book.new(book_params)
    # need also add in handling for missing title - use valid? and errors?
    if params[:book][:author].empty? && params[:book][:author_id].empty?
      render :new
    elsif !params[:book][:author].empty? && !params[:book][:author_id].empty?
      render :new
    elsif !params[:book][:author].empty?
      @book.build_author(name: params[:book][:author])
      @book.save
    else
      @book.save
    end
  end

  private

    def book
      @book ||= Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author_id, :genre, :about)
    end

end
