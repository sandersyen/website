class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  # returns true if the user is logged in
  def logged_in?
    # checks if current_user is not nil
    current_user.presence
  end

  # gets the User model of the current user (or nil if the user is not logged in)
  def current_user
    # find a user by id based on the stored :user_id cookie
    User.find_by_id(session[:user_id])
  end

  def enforce_login(redirect_path)
    if !logged_in?
      redirect_to redirect_path, alert: 'You must be logged in to do that.'
      return true
    end
    return false
  end
end
