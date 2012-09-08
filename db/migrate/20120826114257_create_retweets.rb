class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.integer :retweeter_id
      t.integer :retweeted_post_id


      t.timestamps
    end

    add_index :retweets, :retweeter_id
    add_index :retweets, :retweeted_post_id
     add_index :retweets, [:retweeter_id, :retweeted_post_id], unique: true
  end
end



