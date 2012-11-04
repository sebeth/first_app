class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy,:update]
  before_filter :correct_user,   only: :destroy

  def index
    
  end

  def new
    @post=Post.new
     if !signed_in? 
    redirect_to root_url 
    end
  end


  def create
  	@post = current_user.posts.build(params[:post])
    if @post.save
      
      redirect_to root_url
    else
    	@feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url
  end

   def edit
    @post=Post.find(params[:id])
    @user = @post.user
    
    if !current_user?(@user)
      redirect_to root_url 
    end
    end

    def update
      @post=Post.find(params[:id])
    if @post.update_attributes(params[:post])
      
      redirect_to root_url
    else
      render 'edit_post'
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  private

    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
    end

    def retweeter
      @post = current_user.retweets.posts.find_by_id(params[:id])
    end

  

end