class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.integer :vote, default: 0
      t.boolean :approved, default: false
      t.datetime :to_post, default: Time.now

      t.timestamps
    end
  end
end
