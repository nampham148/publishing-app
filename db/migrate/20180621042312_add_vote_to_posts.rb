class AddVoteToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :vote, :integer, default: 0
  end
end
