# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :photo
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :retweets, foreign_key: "retweeter_id", dependent: :destroy
  has_many :retweeted_posts, through: :retweet, source: :retweeted_post
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_attached_file :photo,
                  :url => "/images/:attachment/:id_:style.:extension",
                  :path => ":rails_root/public/images/:attachment/:id_:style.:extension",
                  :styles => lambda { |a|
                                        { :thumb => "100x100#" }},
                       :whiny => false


  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png"]

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def news
    # This is preliminary. See "Following users" for the full implementation.
    Post.from_users_news(self)
  end

def feed_old
    # This is preliminary. See "Following users" for the full implementation.
    Post.from_users_followed_by(self)
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Post.my_and_retweeted(self)
  end

def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

def retweeted?(user_post)
  retweets.find_by_retweeted_post_id(user_post.id)
end

def retweet!(user_post)
  retweets.create!(retweeted_post_id:user_post.id)
end

def undo_retweet!(user_post)
  retweets.find_by_retweeted_post_id(user_post.id).destroy
end

  private

  def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end
