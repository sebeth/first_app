class Retweet < ActiveRecord::Base
   attr_accessible :retweeted_post_id

  belongs_to :retweeter, class_name: "User"
  belongs_to :retweeted_post, class_name: "Post"

  validates :retweeter_id, presence: true
  validates :retweeted_post_id, presence: true

end