class MembershipsController < ApplicationController
  def create
    membership = Membership.new(params[:membership])
    membership.save
    redirect_to group_path(params[:membership][:group_id])
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.destroy
    redirect_to group_path(membership.group)
  end
end
