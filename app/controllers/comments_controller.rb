class CommentsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @comment = Comment.new
  end

  def create
    book = Book.find(params[:book_id])
    comment = book.comments.build(comment_params)
    comment.comment_writer = current_user
    comment.save
    redirect_to book_path(book)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

end
