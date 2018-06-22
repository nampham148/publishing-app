class AddIndexToVoteRelationship < ActiveRecord::Migration[5.0]
  def change
  	add_index :vote_relationships, [:user_id, :post_id], unique: true
  end
end
