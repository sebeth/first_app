class PostUpdate < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		t.datetime :when 
  		t.string :country
  		t.string :city
  		t.string :title
  		t.string :cathegory
   end
  end
end
