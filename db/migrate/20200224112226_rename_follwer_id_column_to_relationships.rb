class RenameFollwerIdColumnToRelationships < ActiveRecord::Migration[5.2]
  def change
  	rename_column :relationships, :follwer_id, :follower_id
  end
end
