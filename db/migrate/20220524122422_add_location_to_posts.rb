class AddLocationToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :location, :integer, default: :virtual
  end
end
