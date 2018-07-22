class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.any?
      render :new
    else
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def show
    @user = user
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation)
    end

    def user
      @user ||= User.find(params[:id])
    end
end
