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


  ##try to refactor the create action to make it more lean
  def create
    @book = Book.new(book_params)
    if only_new_author?(params)
      a = Author.create(name: params[:book][:author])
      if a.errors[:name].any?
        @book.errors.add(:author, "already exists, please select their name from the dropdown")
      else
        @book.author = a
      end
    elsif double_author_entry?(params)
      @book.errors.add(:author, "must be either selected from existing list or a new name entered")
    end
    if !@book.errors.any? && @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end




  def edit
    @book = book
  end

  def update
    book.update(book_params)
    redirect_to book_path(book)
    # need add more to this to handle if user changes from an existing author to a new author and for handling any errors, if they delete title and such
  end

  private

    def book
      @book ||= Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author_id, :genre, :about)
    end

    def double_author_entry?(params)
      !params[:book][:author].empty? && !params[:book][:author_id].empty?
    end

    def only_existing_author?(params)
      params[:book][:author].empty? && !params[:book][:author_id].empty?
    end

    def only_new_author?(params)
      !params[:book][:author].empty? && params[:book][:author_id].empty?
    end
end
