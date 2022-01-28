class AddHashIdsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :hash_id, :string, null: false
  end
end
