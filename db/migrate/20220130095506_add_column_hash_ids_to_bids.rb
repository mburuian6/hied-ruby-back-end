class AddColumnHashIdsToBids < ActiveRecord::Migration[7.0]
  def change
    add_column :bids, :hash_id, :string
    add_column :accepted_bids, :hash_id, :string
    add_column :rejected_bids, :hash_id, :string
  end
end
