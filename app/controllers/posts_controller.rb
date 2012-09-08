class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def index
  end

  def new
    @post=Post.new
  end


  def create
  	@post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "New recipy has been added!"
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

  private

    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
    end

    def retweeter
      @post = current_user.retweets.posts.find_by_id(params[:id])
    end

end