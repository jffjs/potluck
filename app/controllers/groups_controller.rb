class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    @group.owner = current_user
    @group.members << current_user

    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    if user_signed_in?
      conds = { :group_id => @group, :user_id => current_user }
      @membership = Membership.first(:conditions => conds ) || Membership.new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to root_path
  end
end
