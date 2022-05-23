class NotificationsController < ApplicationController
  before_action :set_username, only: [:all_notifications]
  load_and_authorize_resource

  def all_notifications
    render json: NotificationSerializer.to_collection(
      Notification.order(notification_opened: :desc, updated_at: :desc).where(username: @username)
    )
  end

  def mark_read
    notification = Notification.find_by(hash_id: params[:hash_id])
    if notification.opened!
      render json: nil, status: :ok
    else
      render json: notification, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_username
    params_username = params[:username]
    @username = params_username if params_username.to_s == current_user.username.to_s
  end

  # Only allow a list of trusted parameters through.
  def notification_params
    params.require(:notification).permit(:subject, :message)
  end
end
