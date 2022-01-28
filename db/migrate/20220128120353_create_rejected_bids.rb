class CreateRejectedBids < ActiveRecord::Migration[7.0]
  def change
    create_table :rejected_bids do |t|
      t.decimal :pay
      t.text :notes
      t.references :post, null: false, foreign_key: true
      t.string :owner

      t.timestamps
    end
  end
end
