class ProfileUpdate < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.date :birthday 
  		t.string :country
  		t.string :city
  		t.text :intersts
  		t.text :description

  end
 end

end
