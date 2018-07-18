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
    if only_new_author?(params)
      a = Author.create(name: params[:book][:author])
      if a.errors[:name].any?
        book.errors.add(:author, "already exists, please select their name from the dropdown")
      else
        book.update(author: a)
      end
    elsif double_author_entry?(params)
      book.errors.add(:author, "must be either selected from existing list or a new name entered")
    elsif no_author_entry?(params)
      book.errors.add(:author, "must be entered")
    end
    if book.errors.any?
      render :edit
    else
      redirect_to book_path(book)
    end
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

    def no_author_entry?(params)
      params[:book][:author].empty? && params[:book][:author_id].empty?
    end

end
