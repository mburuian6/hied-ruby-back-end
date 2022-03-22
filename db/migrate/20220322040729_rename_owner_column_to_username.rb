class RenameOwnerColumnToUsername < ActiveRecord::Migration[7.0]
  def up
    rename_column :accepted_bids, :owner, :username
    rename_column :bids, :owner, :username
    rename_column :notifications, :owner, :username
    rename_column :posts, :owner, :username
    rename_column :rejected_bids, :owner, :username

    add_index :accepted_bids, :username, if_not_exists: true
    add_index :bids, :username, if_not_exists: true
    add_index :notifications, :username, if_not_exists: true
    add_index :posts, :username, if_not_exists: true
    add_index :rejected_bids, :username, if_not_exists: true
  end

  def down
    rename_column :accepted_bids, :username, :owner
    rename_column :bids, :username, :owner
    rename_column :notifications, :username, :owner
    rename_column :posts, :username, :owner
    rename_column :rejected_bids, :username, :owner

    remove_index :accepted_bids, :username, if_not_exists: true
    remove_index :bids, :username, if_not_exists: true
    remove_index :notifications, :username, if_not_exists: true
    remove_index :posts, :username, if_not_exists: true
    remove_index :rejected_bids, :username, if_not_exists: true
  end
end
