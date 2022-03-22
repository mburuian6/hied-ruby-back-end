class AddBidCreatedAndUpdatedToAcceptAndRejectClones < ActiveRecord::Migration[7.0]
  def change
    add_column :accepted_bids, :original_bid_created, :timestamp
    add_column :accepted_bids, :original_bid_updated, :timestamp
    add_column :rejected_bids, :original_bid_created, :timestamp
    add_column :rejected_bids, :original_bid_updated, :timestamp
  end
end
