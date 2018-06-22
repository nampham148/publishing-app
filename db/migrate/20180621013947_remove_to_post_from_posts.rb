class RemoveToPostFromPosts < ActiveRecord::Migration[5.0]
  def change
  	remove_column :posts, :to_post
  	add_column :posts, :to_post, :datetime
  	remove_column :posts, :vote
  end
end
