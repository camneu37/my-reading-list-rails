class BooksController < ApplicationController
  before_action :authentication_required

  def index
    if params.has_key?("date") && !params[:date].empty?
      @books = Book.added_in_past(params[:date])
    else
      @books = Book.all_alphabetized
    end
  end

  def show
    @book = book
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new_from_params(book_params, params[:book][:author_name])
    if !@book.errors.any? && @book.save
      @book.update(creator_id: current_user.id)
      current_user.add_book_to_reading_list(@book)
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
    @book = book
    if @book.creator_id != current_user.id
      redirect_to book_path(@book)
    end
  end

  def update
    @book = book.update_from_params(book_params, params[:book][:author_name])
    if @book.errors.any?
      render :edit
    else
      redirect_to book_path(@book)
    end
  end

  def destroy
    book.destroy
    flash[:message] = "You've successfully deleted #{book.title}."
    redirect_to books_path
  end

  def add
    @book = book
    current_user.add_book_to_reading_list(@book)
    redirect_to user_path(current_user)
  end

  def remove
    @book = book
    current_user.remove_book_from_reading_list(@book)
    redirect_to user_path(current_user)
  end

  private

    def book
      @book ||= Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author_id, :genre, :about)
    end

end
