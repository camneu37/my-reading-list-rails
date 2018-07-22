class ApplicationController < ActionController::Base
  include ApplicationHelper

  def authentication_required
    redirect_to root_path unless logged_in?
  end

end
