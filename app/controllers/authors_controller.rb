class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = author
  end

  private
    def author
      @author ||= Author.find(params[:id])
    end
end
