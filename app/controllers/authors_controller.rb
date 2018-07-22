class AuthorsController < ApplicationController
  before_action :authentication_required

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
