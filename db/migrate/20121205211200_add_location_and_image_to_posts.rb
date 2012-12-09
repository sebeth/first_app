class AddLocationAndImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.has_attached_file :m_photo
      t.text :location
    end
  end

  def self.down
    drop_attached_file :posts, :m_photo
  end
end

