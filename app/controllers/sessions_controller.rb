class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(username: params[:username])
    if auth
      @user = User.find_or_create_by(uid: auth[:uid]) do |u|
        u.name = auth[:info][:name]
        u.username = auth[:info][:name]
        u.password = SecureRandom.hex
        u.password_confirmation = u.password
      end
      binding.pry
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    elsif params[:username].empty? || params[:password].empty?
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
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end

  private
    def auth
      request.env['omniauth.auth']
    end

end
