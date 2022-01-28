class ChangeStartColumnOnPostsToDateTime < ActiveRecord::Migration[7.0]
  def up
    remove_column :posts, :start
    add_column :posts, :start, :datetime, default: DateTime.now, null: false
  end

  def down
    remove_column :posts, :start
    add_column :posts, :start, :integer, default: 0, null: false
  end
end
