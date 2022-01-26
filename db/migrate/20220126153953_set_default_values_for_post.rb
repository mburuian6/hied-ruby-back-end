class SetDefaultValuesForPost < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :title, from: nil, to: 'New Post'
    change_column_default :posts, :closed, from: nil, to:false
    change_column_default :posts, :pay, from: nil, to: false
    change_column_default :posts, :description, from: nil, to: 'New Description'
    change_column_default :posts, :start, from: nil, to: DateTime.now
  end
end
