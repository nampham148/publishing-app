class Post < ApplicationRecord
  belongs_to :user

  has_many :positive_relationships, -> { where(positive: true) }, class_name: "VoteRelationship", dependent: :destroy
  has_many :negative_relationships, -> { where(positive: false) }, class_name: "VoteRelationship", dependent: :destroy
  has_many :like_users, through: :positive_relationships, source: :user
  has_many :dislike_users, through: :negative_relationships, source: :user

  validates :content, presence: true
  validates :user_id, presence: true
  validates :to_post, presence: true

  def post_date
    posted_at.to_date
  end

  def popularity
    self.like_users.count - self.dislike_users.count
  end
end
