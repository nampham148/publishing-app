class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :posts
  validates :name, presence: true, on: :create

  has_many :positive_relationships, -> { where(positive: true) }, class_name: 'VoteRelationship', dependent: :destroy
  has_many :negative_relationships, -> { where(positive: false) }, class_name: 'VoteRelationship', dependent: :destroy
  has_many :liked_posts, through: :positive_relationships, source: :post
  has_many :disliked_posts, through: :negative_relationships, source: :post

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def like?(post)
    self.liked_posts.include?(post)
  end

  def dislike?(post)
    self.disliked_posts.include?(post)
  end

  def like(post)
    self.disliked_posts.delete(post) if self.dislike?(post)
    self.liked_posts << post
  end

  def dislike(post)
    self.liked_posts.delete(post) if self.like?(post)
    self.disliked_posts << post
  end

  def neutralize(post)
    self.liked_posts.delete(post) if self.like?(post)
    self.disliked_posts.delete(post) if self.dislike?(post)
  end

end
