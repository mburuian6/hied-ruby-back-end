class RemoveSubjectAndMessageFromNotifications < ActiveRecord::Migration[7.0]
  def up
    remove_column :notifications, :subject
    remove_column :notifications, :message
  end

  def down
    add_column :notifications, :subject, :string
    add_column :notifications, :message,:text
  end
end
