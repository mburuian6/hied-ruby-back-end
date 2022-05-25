class CreateCoordinates < ActiveRecord::Migration[7.0]
  def change
    create_table :coordinates do |t|

      t.string :latitude
      t.string :longitude
      t.references :post
      t.timestamps
    end
  end
end
