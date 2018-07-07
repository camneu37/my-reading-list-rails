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
    if !params[:book][:author].empty? && !params[:book][:author_id].empty?
      @book.errors[:base] << "You cannot select an existing author and enter a new author."
      render :new
    elsif !params[:book][:author].empty?
      @book.build_author(name: params[:book][:author])
      if @book.save
        redirect_to book_path(@book)
      else
        render :new
      end
    elsif !@book.valid?
      render :new
    else
      @book.save
      redirect_to book_path(@book)
    end
  end

  def edit
    @book = book
  end

  private

    def book
      @book ||= Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author_id, :genre, :about)
    end

end
