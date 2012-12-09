class Post < ActiveRecord::Base
  attr_accessible :content, :ingredients, :name, :user_id,
          :country, :city, :title, :cathegory, :date, :hour, :minute, :tag_list, 
          :location, :m_photo
  acts_as_taggable
  belongs_to :user 
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 5000 }
  has_many :retweets, foreign_key: "retweeted_post_id", dependent: :destroy
  has_many :retweeters, through: :retweets, source: :retweeter

  has_attached_file :m_photo,
                   :default_url => "/images/:attachment/m_:style.png",
                   :default_path => ":rails_root/public/images/:attachment/m_:style.png",
                  :url => "/images/:attachment/m_:id_:style.:extension",
                  :path => ":rails_root/public/images/:attachment/m_:id_:style.:extension",
                  :styles => { :thumb => "75x75#", 
                                :profile => "200x200>"},
                  :convert_options => { 
                                      :profile => "-gravity center -extent 200x200"}
                  


  validates_attachment_content_type :m_photo, :content_type => ["image/jpeg", "image/jpg", "image/png"]
  validates_attachment_size :m_photo, :less_than => 5.megabytes


   default_scope order: 'posts.created_at DESC'

   CATHEGORIES = ["Event (concert, exhibition etc.)","Eating out","Hobbies","New in the city", 
    "Nightlife","Shopping", "Sport" ,"Traveling", "Other.."]

 def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end


  def self.from_users_news(user)
   post_ids = "SELECT post_id FROM posts"
    where("posts.id IN (#{post_ids})")
    order("updated_at DESC")
  end
   

def self.my_and_retweeted(user)



    retweeted_post_ids = "SELECT retweeted_post_id FROM retweets
                         WHERE retweeter_id = :user_id"

    where("(user_id = :user_id) OR id IN (#{retweeted_post_ids})", 
          user_id: user.id)
  end

end
