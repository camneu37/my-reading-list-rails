class CommentsController < ApplicationController

  def create
    comment = commented_book.comments.build(comment_params)
    comment.comment_writer = current_user
    comment.save
    redirect_to book_path(commented_book)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def commented_book
      @book ||= Book.find(params[:book_id])
    end

end
