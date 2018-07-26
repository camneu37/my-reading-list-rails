class CommentsController < ApplicationController

  def new
    @book = commented_book
    @comment = Comment.new
  end

  def create
    book = Book.find(params[:book_id])
    comment = book.comments.build(comment_params)
    comment.comment_writer = current_user
    comment.save
    redirect_to book_path(book)
  end

  def index
    @book = commented_book
    @comments = commented_book.comments
    if @comments.empty?
      redirect_to book_path(@book)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def commented_book
      @book ||= Book.find(params[:book_id])
    end

end
