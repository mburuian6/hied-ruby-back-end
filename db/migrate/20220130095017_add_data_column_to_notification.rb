class AddDataColumnToNotification < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :data, :jsonb, default: {}
  end
end
