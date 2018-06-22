class AddPostedAtToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :posted_at, :datetime
  end
end
