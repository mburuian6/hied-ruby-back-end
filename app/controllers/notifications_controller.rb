class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show update destroy ]
  load_and_authorize_resource

  def all_notifications
    username = params[:username]
    render json: NotificationSerializer.to_collection(
      Notification.order(:updated_at).where(username: username)
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end


  # Only allow a list of trusted parameters through.
  def notification_params
    params.require(:notification).permit(:subject, :message)
  end
end
