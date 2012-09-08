class RetweetsController < ApplicationController
  before_filter :signed_in_user

  def create
    @post = Post.find(params[:retweet][:retweeted_post_id])
    current_user.retweet!(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js {}
      #{render :partial => '/shared/undo_retweet',:locals => { :feed_item => @post }}
    end
  end

  def destroy
    @post = Retweet.find(params[:id]).retweeted_post
    current_user.undo_retweet!(@post)
    @feed_items = current_user.feed.paginate(page: params[:page])
    respond_to do |format|
      format.html { redirect_to @post }
      format.js {}
      #{render :partial => '/shared/retweet',:locals => { :feed_item => @post }} { |page| page.reload }
    end
  end

  def remove
    @post = Retweet.find(params[:id]).retweeted_post
    current_user.undo_retweet!(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js {}
      #{render :partial => '/shared/retweet',:locals => { :feed_item => @post }} { |page| page.reload }
    end
  end
end