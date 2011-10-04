require 'spec_helper'

describe FriendshipsController do
  include Devise::TestHelpers
  
  let(:current_user) { mock_model(User).as_null_object }
  let(:friend) { mock_model(User).as_null_object }
  
  before do
    controller.stub(:authenticate_user!).and_return(true)
    controller.stub(:current_user).and_return(current_user)
  end
  
  describe "GET index" do
    it "displays the user's friends" do
      current_user.should_receive(:friends)
      get :index
    end
    
    it "should render the correct template" do
      get :index
      response.should render_template('index')
    end
  end
  
  describe "POST create" do
    before do
      current_user.stub(:requested_friends).and_return([])
      current_user.stub(:friends).and_return([])
      current_user.stub(:pending_friends).and_return([])
      User.stub(:find).and_return(friend)
    end
    
    it "should redirect to root path" do
      post :create
      response.should redirect_to root_path
    end
    
    it "requests a friendship with user" do
      current_user.should_receive(:request_friend).with(friend)
      post :create, :friend_id => friend.id
    end
    
    it "should set a flash[:notice] message" do
      post :create, :friend_id => friend.id
      flash[:notice].should =~ /Friendship requested/
    end
    
    context "with a user you have already requested friendship with" do
      before do
        current_user.stub(:requested_friends).and_return([friend])
      end
      
      it "should not add the user as a requested friend again" do
        current_user.should_not_receive(:request_friend)
        post :create, :friend_id => friend.id
      end
      
      it "should set a flash[:notice] message" do
        post :create, :friend_id => friend.id
        flash[:notice].should =~ /Friendship request is pending/
      end
    end
    
    context "with a user that has already requested friendship with you" do
      it "should accept that user as a friend" do
        current_user.stub(:pending_friends).and_return([friend])
        current_user.should_receive(:accept_friend).with(friend)
        post :create, :friend_id => friend.id
      end
    end
    
    context "with a user that you are already friends with" do
      before do
        current_user.stub(:friends).and_return([friend])
      end
      
      it "should not add the user as a requested friend again" do
        current_user.should_not_receive(:request_friend)
        post :create, :friend_id => friend.id
      end
      
      it "should set a flash[:notice] message" do
        post :create, :friend_id => friend.id
        flash[:notice].should =~ /You are already friends with/
      end
    end
  end
  
  describe "POST accept" do
    before do
      User.stub(:find).and_return(friend)
    end
    
    it "should redirect to root path" do
      post :accept, :friend_id => friend.id
      response.should redirect_to root_path
    end
    
    it "accepts the friendship with the user" do
      current_user.should_receive(:accept_friend).with(friend)
      post :accept, :friend_id => friend.id
    end
    
    it "should set a flash[:notice] message" do
      post :accept, :friend_id => friend.id
      flash[:notice].should =~ /You are now friends with/
    end
  
    context "with a user that has not requested friendship with you" do
      before do
        current_user.stub(:pending_friends).and_return([])
        current_user.stub(:ignored_pending_friends).and_return([])
        current_user.stub(:requested_friends).and_return([])
        current_user.stub(:friends).and_return([])
      end
      
      it "should not accept the friendship" do
        current_user.should_not_receive(:accept_friend)
        post :accept, :friend_id => friend.id
      end
      
      it "should set a flash[:alert] message" do
        post :accept, :friend_id => friend.id
        flash[:alert].should =~ /has not requested friendship with you/
      end
    end
  
    context "with a user that you have requested friendship with" do
      before do
        current_user.stub(:requested_friends).and_return([friend])
        current_user.stub(:pending_friends).and_return([])
        current_user.stub(:ignored_pending_friends).and_return([])
      end
      
      it "should not accept the friendship" do
        current_user.should_not_receive(:accept_friend)
        post :accept, :friend_id => friend.id
      end
      
      it "should set a flash[:alert] message" do
        post :accept, :friend_id => friend.id
        flash[:alert].should =~ /You must wait for this user to accept your friendship/
      end
    end
    
    context "with a user that you are already friends with" do
      before do
        current_user.stub(:friends).and_return([friend])
        current_user.stub(:requested_friends).and_return([])
        current_user.stub(:pending_friends).and_return([])
        current_user.stub(:ignored_pending_friends).and_return([])
      end
      
      it "should not accept the friendship" do
        current_user.should_not_receive(:accept_friend)
        post :accept, :friend_id => friend.id
      end
      
      it "should set a flash[:alert] message" do
        post :accept, :friend_id => friend.id
        flash[:alert].should =~ /You are already friends with/
      end
    end
  end
  
  describe "POST ignore" do
    before do
      User.stub(:find).and_return(friend)
    end
    
    it "should redirect to root path" do
      post :ignore, :friend_id => friend.id
      response.should redirect_to root_path
    end
    
    it "should ignore the friendship request" do
      current_user.should_receive(:ignore_friend_request).with(friend)
      post :ignore, :friend_id => friend.id
    end
    
    it "should set a flash[:notice] message" do
      post :ignore, :friend_id => friend.id
      flash[:notice].should =~ /Friendship request ignored/
    end
  end
  
  describe "POST remove" do
    before do
      User.stub(:find).and_return(friend)
    end
    
    it "should display a confirmation message if no confirm param is passed" do
      post :remove, :friend_id => friend.id
      response.should render_template('remove')
    end
    
    context "with confirm = 'prompt'" do
      it "displays a confirmation message" do
        post :remove, :confirm => 'prompt', :friend_id => friend.id
        response.should render_template('remove')
      end
    end
    
    context "with confirm = 'yes'" do
      it "removes the friendship with the specified friend" do
        current_user.should_receive(:remove_friend).with(friend)
        post :remove, :confirm => 'yes', :friend_id => friend.id
      end
      
      it "should redirect to the removed friend's profile" do
        post :remove, :confirm => 'yes', :friend_id => friend.id
        response.should redirect_to user_path(friend)
      end
      
      it "should set a flash[:notice] message" do
        post :remove, :confirm => 'yes', :friend_id => friend.id
        flash[:notice].should =~ /You are no longer friends with/
      end
    end
    
    context "with confirm = 'no'" do
      it "does not remove the friendship with the specified friend" do
        current_user.should_not_receive(:remove_friend)
        post :remove, :confirm => 'no', :friend_id => friend.id
      end
      
      it "should redirect to the friend's profile" do
        post :remove, :confirm => 'no', :friend_id => friend.id
        response.should redirect_to user_path(friend)
      end
    end
  end
end
