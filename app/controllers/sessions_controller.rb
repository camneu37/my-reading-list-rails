class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if params[:username].empty? || params[:password].empty?
      flash[:message] = "Must fill in username and password fields"
      render :new
    elsif @user.nil?
      flash[:message] = "We couldn't find an account with that username, please try again or create a new account."
      render :new
    elsif !@user.authenticate(params[:password])
      flash[:message] = "The password you entered was incorrect. Please try again."
      render :new
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    end
  end

  def destroy
  end

end
