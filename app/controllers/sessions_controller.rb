class SessionsController < ApplicationController
  include SessionsHelper

  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    user = sessions_user(params, auth)
    if user.errors.any?
      render :new
    else
      session[:user_id] = user.id
      redirect_to user_path(user)
    end
  end

  def destroy
    session.delete(:user_id)
    current_user = nil
    redirect_to root_path
  end

  private
    def auth
      request.env['omniauth.auth']
    end

end
