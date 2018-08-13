class AuthorsController < ApplicationController
  before_action :authentication_required

  def index
    @authors = Author.all_alphabetized
  end

  def show
    @author = author
    # @avg_rating = Rating.avg_rating("Author", @author)
  end

  private
    def author
      @author ||= Author.find(params[:id])
    end
end
