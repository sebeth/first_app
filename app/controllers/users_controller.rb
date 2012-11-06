class UsersController < ApplicationController
 before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers]
 before_filter :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @country=Carmen::Country.coded(@user.country)
  end



def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

def events
    @title = "My Events"
    @user = User.find(params[:id])
    # @feed_items = current_user.feed.paginate(page: params[:page])
    @posts = @user.posts.paginate(page: params[:page])
    if current_user?(@user)
    render 'show_my_events'
    else
      redirect_to(root_path)
    end
   end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  def new
    @user = User.new
  end

 def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to edit_user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  end

  #def edit_password
   # render 'edit_password'
  #end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

 

def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
