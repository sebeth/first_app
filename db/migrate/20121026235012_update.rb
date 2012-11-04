class Update < ActiveRecord::Migration
  def change
  	remove_column :posts, :when
  	add_column :posts, :date, :date
  	add_column :posts, :hour, :integer
  	add_column :posts, :minute, :integer
  end
end
