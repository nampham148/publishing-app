class CreateVoteRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_relationships do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :positive

      t.timestamps
    end
  end
end
