class Post < ApplicationRecord
	belongs_to :user
	validates :content, presence: true
	validates :user_id, presence: true
	validates :to_post, presence: true
end
