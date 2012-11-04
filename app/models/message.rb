class Message < ActiveRecord::Base

  is_private_message
  
#create_table :messages do |t|
 #     t.integer :sender_id, :recipient_id
  #    t.boolean :sender_deleted, :recipient_deleted, :default => false
   #   t.string :subject
    #  t.text :body
     # t.datetime :read_at
      #t.timestamps
    #end

  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  attr_accessible :to, :subject, :body
   attr_accessor  :to

end