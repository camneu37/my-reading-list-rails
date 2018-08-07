class RatingsController < ApplicationController

  #NEED REFACTOR THIS!
  def create
    if params[:book_id]
      book = Book.find(params[:book_id])
      if book.already_rated_by_user?(current_user)
        flash[:message] = "You've already submitted a rating for this book."
      else
        rating = book.ratings.create(rating: params[:rating], user_id: current_user.id)
      end
      redirect_to book_path(book)
    elsif params[:author_id]
      author = Author.find(params[:author_id])
      if author.already_rated_by_user?(current_user)
        flash[:message] = "You've already submitted a rating for this book."
      else
        rating = author.ratings.create(rating: params[:rating], user_id: current_user.id)
      end
      rediect_to author_path(author)
    end
  end

end
