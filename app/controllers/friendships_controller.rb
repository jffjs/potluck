class FriendshipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_friend, :except => [:index]
  
  def index
    @friends = current_user.friends
  end
  
  def create    
    if current_user.friends.include?(@friend)
      flash[:notice] = "You are already friends with #{@friend.name}"
    elsif current_user.requested_friends.include?(@friend)      
      flash[:notice] = "Friendship request is pending"
    elsif current_user.pending_friends.include?(@friend)
      accept_friend
    else
      current_user.request_friend(@friend)
      flash[:notice] = "Friendship requested"     
    end
    
    redirect_to root_path #user_path(1)
  end
  
  def accept    
    if current_user.pending_friends.include?(@friend) || current_user.ignored_pending_friends.include?(@friend)
      accept_friend
    elsif current_user.requested_friends.include?(@friend)
      flash[:alert] = "You must wait for this user to accept your friendship"
    elsif current_user.friends.include?(@friend)
      flash[:alert] = "You are already friends with #{@friend.name}"
    else
      flash[:alert] = "#{@friend.name} has not requested friendship with you"
    end
      
    redirect_to root_path
  end
  
  def ignore    
    if current_user.pending_friends.include?(@friend)
      current_user.ignore_friend_request(@friend)
      flash[:notice] = "Friendship request ignored"
    end
    redirect_to root_path
  end
  
  def remove
    if params[:confirm] == 'prompt'
      render
    elsif params[:confirm] == 'yes'
      current_user.remove_friend(@friend)
      flash[:notice] = "You are no longer friends with #{@friend.name}"
      redirect_to user_path(@friend)
    elsif params[:confirm] == 'no'
      redirect_to user_path(@friend)
    end
  end
  
  private
  
  def find_friend
    @friend = User.find(params[:friend_id])
  end
  
  def accept_friend
    current_user.accept_friend(@friend)
    flash[:notice] = "You are now friends with #{@friend.name}"
  end
end
