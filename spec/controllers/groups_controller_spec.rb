require 'spec_helper'

describe GroupsController do
  let(:current_user) { mock_model(User).as_null_object }

  before do
    controller.stub(:current_user).and_return(current_user)
  end

  describe "GET new" do

    it "creates an unsaved group" do
      Group.should_receive(:new)
      get :new
    end

    it "should render the 'new' template" do
      get :new
      response.should render_template('new')
    end

    it "assigns @group" do
      get :new
      assigns[:group].should_not be_nil
    end
  end

  describe "POST create" do
    let(:group) { mock_model(Group).as_null_object }

    before do
      Group.stub(:new).and_return(group)
      @attr = { 'name' => "Group",
                'description' => "group desc" }
    end

    it "creates a new group" do
      Group.should_receive(:new).with(@attr).and_return(group)
      post :create, :group => @attr
    end

    it "saves the group" do
      group.should_receive(:save)
      post :create, :group => @attr
    end

    it "sets the current_user as owner of group" do
      group.should_receive(:owner=).with(current_user)
      post :create, :group => @attr
    end

    context "when the group saves successfully" do
      before do
        group.stub(:save).and_return(true)
      end

      it "should redirect to the new group's show path" do
        post :create, :group => @attr
        response.should redirect_to group_path(group)
      end
    end

    context "when the group fails to save" do
      before do
        group.stub(:save).and_return(false)
      end

      it "assigns @group" do
        post :create
        assigns[:group].should == group 
      end

      it "should render the 'new' template" do
        post :create
        response.should render_template('new')
      end
    end
  end
end
