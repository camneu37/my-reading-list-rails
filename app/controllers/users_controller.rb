class UsersController < ApplicationController

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
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
    if current_user != user
      redirect_to root_path
    else
      @user
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation)
    end

    def user
      @user ||= User.find(params[:id]) if User.exists?(params[:id])
    end
end
