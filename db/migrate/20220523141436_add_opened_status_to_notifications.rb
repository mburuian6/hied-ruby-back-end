class AddOpenedStatusToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :notification_opened, :integer, default: :unopened
  end
end
