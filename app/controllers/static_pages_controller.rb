class StaticPagesController < ApplicationController
  def home
    if signed_in?
     @post = current_user.posts.build
     @feed_items = current_user.feed.paginate(page: params[:page])
  end
  end

  def help
  end

  def about
  end

  def contact
  end

  def edit_password
    @user=current_user
  end

  def news
    if signed_in?
     @post = current_user.posts.build

if params[:search]
 @search= Post.search(params[:search])
     @feed_items = @search.paginate(page: params[:page])
elsif params[:tag]
  @all=Post.tagged_with(params[:tag])
  @feed_items = @all.paginate(page: params[:page])
   @search= Post.search(params[:search])
else
     @search= Post.search(params[:search])
     @feed_items = @search.paginate(page: params[:page])
  end   
    # @feed_items = current_user.news.paginate(page: params[:page])
  end
 end

end
