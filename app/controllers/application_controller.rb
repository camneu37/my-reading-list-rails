class ApplicationController < ActionController::Base
  include ApplicationHelper

  def authentication_required
    if !logged_in?
      redirect_to root_path
    end
  end

end
