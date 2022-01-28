class AddOwnersAndNotificationReferencesToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :owner, :string, null: false
    add_column :notifications, :notification_references, :text, array: true, default: []
  end
end
