class NotificationsController < ApplicationController
  # GET /notifications
  def index
    return if enforce_login(home_path)
    @notifications = current_user.notifications

    Notification.mark_read(@notifications)
  end

  # DELETE /notifications/:id
  def destroy
    return if enforce_login(home_path)

    @notification = Notification.find(params[:id])

    if current_user != @notification.user
      redirect_to home_path, alert: 'You are not allowed to do that.'
      return
    end

    @notification.destroy
  end
end
