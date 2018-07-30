module SessionsHelper

  def sessions_user(params, auth)
    if auth
      user = User.find_or_create_from_auth(auth)
    elsif params[:username].empty? || params[:password].empty?
      user = User.new
      user.errors.add(:base, "You must enter a username and password to login.")
    elsif user = User.find_by(username: params[:username])
      if !user.authenticate(params[:password])
        user.errors.add(:password, "entered was incorrect. Please try again.")
      elsif user && user.authenticate(params[:password])
        user
      end
    else
      user = User.new
      user.errors.add(:username, "entered does not exist. Please try again or create an account.")
    end
    user
  end

end
