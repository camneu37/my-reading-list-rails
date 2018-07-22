class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    book = Book.find(params[:book_id])
    comment.book_commented = book
    comment.comment_writer = current_user
    comment.save
    redirect_to book_path(book)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

end
