require 'spec_helper'

describe MembershipsController do
  let(:membership) { mock_model(Membership).as_null_object }

  describe "POST create" do
    before do
      Membership.stub(:new).and_return(membership)
      @attr = { 'user_id' => '1',
                'group_id' => '1' }
    end

    it "creates a new membership" do
      Membership.should_receive(:new).with(@attr).and_return(membership)
      post :create, :membership => @attr
    end

    it "saves the membership" do
      membership.should_receive(:save)
      post :create, :membership => @attr
    end

    context "when the membership is created successfully" do
      before do
        membership.stub(:save).and_return(true)
      end

      it "should redirect to the group's show path" do
        post :create, :membership => @attr
        response.should redirect_to group_path(@attr['group_id'])
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Membership.stub(:find).and_return(membership)
      membership.stub(:group).and_return('1')
      @attr = { 'user_id' => '1',
                'group_id' => '1' }
    end

    it "finds the membership to destroy" do
      Membership.should_receive(:find).with(membership.id.to_s).and_return(membership)
      delete :destroy, :id => membership
    end

    it "should destroy the membership" do
      membership.should_receive(:destroy)
      delete :destroy, :id => membership
    end

    context "when membership is successfully destroyed" do
      before do
        membership.stub(:destroy).and_return(true)
      end

      it "should redirect to the group's show path" do
        delete :destroy, :id => membership
        response.should redirect_to group_path(membership.group)
      end
    end
  end
end
