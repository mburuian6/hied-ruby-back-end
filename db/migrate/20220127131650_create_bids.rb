class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.decimal :pay, precision: 10, scale: 2, default: 0.00
      t.text :notes, default: ''
      t.references :post, null: false, foreign_key: true
      t.string :owner

      t.timestamps
    end
  end
end
