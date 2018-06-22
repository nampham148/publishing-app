class VoteRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :positive, inclusion: { in: [ true, false ] }
  validate :different_user

  private
    def different_user
      if self.post.user == self.user
        errors.add(:user, "cannot like/dislike his own posts")
      end
    end
end
