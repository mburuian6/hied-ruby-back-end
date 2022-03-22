class EnforceOwnersReferentialIntegrity < ActiveRecord::Migration[7.0]
  def up
    # add_foreign_key :contents, :projects, column: :project_id
  end

  def down; end
end
