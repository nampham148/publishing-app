class AddDefaultValueOnImageUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :image
  	add_column :users, :image, :text, default: "default-profile.jpg"
  end
end
