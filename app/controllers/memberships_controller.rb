class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    membership = Membership.first(conditions: { group_id: params[:group_id],
                                                user_id:  current_user.id })
    if membership
      if membership.pending?
        membership.pending = false
        membership.save
      else
        flash[:alert] = "You are already a member of this group."
      end
    else
      group = Group.find(params[:group_id])
      if group.private?
        flash[:alert] = "You must be invited in order to join this group."
      else
        membership = Membership.new(group_id: params[:group_id],
                                    user_id: current_user.id)
        membership.save
      end
    end
    redirect_to group_path(params[:group_id])
  end

  def destroy
    membership = Membership.find(params[:id])
    if membership.group.owner == current_user
      flash[:alert] = "You cannot leave this group until you assign a new owner."
    else
      membership.destroy
    end
    redirect_to root_path
  end

  def invite
    membership = Membership.new(group_id: params[:group_id],
                                user_id:  params[:user_id],
                                pending: true)
    membership.save
    flash[:notice] = "Invitation sent."
    redirect_to group_path(params[:group_id])
  end
end
