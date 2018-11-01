class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      redirect_to home_path, notice: 'You logged in successfully!'
    else
      redirect_to home_path, alert: 'Authentication failed, please try again.'
    end
  end

  def destroy
    cookies.signed[:user_id] = nil
    redirect_to home_path
  end

  private
    def authenticate_with_google
      if flash[:google_sign_in_token].present?
        identity = GoogleSignIn::Identity.new(flash[:google_sign_in_token])
        user = User.find_by_id(google_id: identity.user_id)
        if user == nil
          user = User.create(google_id: identity.user_id, name: identity.name, email: identity.email_address, avatar_url: identity.avatar_url)
        end
        return user
      end
      return nil
    end
end