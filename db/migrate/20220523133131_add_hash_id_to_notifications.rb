class AddHashIdToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :hash_id, :string
  end
end
