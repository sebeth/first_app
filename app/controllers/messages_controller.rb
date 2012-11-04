class MessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @messages = @user.sent_messages
    else
      @messages = @user.received_messages
    end
  end
  
  def show
    @message = Message.read_message(params[:id], current_user)
  end
  
  def new
    @message = Message.new
    @message.recipient=User.find_by_id(params[:rec])
  

    if params[:reply_to]
      @reply_to = @user.received_messages.find(params[:reply_to])
      @message.recipient = @reply_to.sender
      unless @reply_to.nil?
        @message.to = @reply_to.sender.name
        @message.subject = "Re: #{@reply_to.subject}"
        @message.body = "\n\n*Original message*\n\n #{@reply_to.body}"
      end
    end
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = @user
    @message.recipient = User.find_by_id(params[:message][:to])
  
    #@message.recipient = User.find_by_id(params[:message][:to])

    if @message.save
      flash[:notice] = "Message sent"
      redirect_to user_messages_path(@user)
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
     unless params[:delete_ids].blank?
       params[:delete_ids].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @user, @user])
          @message.mark_deleted(@user) unless @message.nil?
        }
        flash[:notice] =  "Messages deleted"
      end

      redirect_to :back
          
    end
  end
  
  private
    def set_user
      @user = current_user
      @recipient = User.find_by_id(params[:recipient_id])
    end
end