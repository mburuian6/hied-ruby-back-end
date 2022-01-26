class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.decimal :pay
      t.boolean :closed
      t.text :description
      t.integer :start
      t.string :owner

      t.timestamps
    end
  end
end
