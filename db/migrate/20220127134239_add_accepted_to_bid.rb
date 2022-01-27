class AddAcceptedToBid < ActiveRecord::Migration[7.0]
  def change
    add_column :bids, :accepted, :boolean, default: false
  end
end
