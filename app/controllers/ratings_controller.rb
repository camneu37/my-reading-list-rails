class RatingsController < ApplicationController

  def create
    binding.pry
    if params[:book_id]
      book = Book.find(params[:book_id])
      if book.already_rated_by_user(current_user)
        flash[:message] = "You've already submitted a rating for this book."
      else
        rating = book.ratings.create(rating: params[:rating], user_id: current_user.id)
      end
    elsif params[:author_id]
      author = Author.find(params[:author_id])
      if current_user.has_already_rated?(author)
        flash[:message] = "You've already submitted a rating for this book."
      else
        rating = author.ratings.create(rating: params[:rating], user_id: current_user.id)
      end
    end
  end

end
