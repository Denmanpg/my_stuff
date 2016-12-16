class UsersController < ApplicationController
  
  before_action :set_user, only: [:show,:messages]
  before_action :authenticate_user!

  def index
    case params[:people]
    when "friends"
      @users = current_user.active_friends
    when "requested"
      @users = current_user.pending_friend_requests_to
    when "pending"
      @users = current_user.pending_friend_requests_from
    else
      @users = User.where.not(id: current_user.id)
    end
  end

  def messages
    case params[:filter]
    when "sent"
      @messages=current_user.get_sent
    else
      @messages=current_user.get_inbox
    end
  end

  def show
    @post = Post.new
    @posts = @user.posts.order('created_at DESC')
    @activities = PublicActivity::Activity.where(owner_id: @user.id)
    @message=Message.new
  end

  def set_user
    @user = User.find_by(username: params[:id])
  end
  
end