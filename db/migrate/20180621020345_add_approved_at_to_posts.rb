class AddApprovedAtToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :approved_at, :datetime
  end
end
