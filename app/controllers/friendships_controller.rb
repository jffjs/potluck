class FriendshipsController < ApplicationController
  def create
    current_user.request_friend(params[:friend_id])
    flash[:notice] = "Friendship requested"
    redirect_to root_path #user_path(1)
  end
end
