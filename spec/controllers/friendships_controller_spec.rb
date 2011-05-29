require 'spec_helper'

describe FriendshipsController do
  let(:current_user) { mock_model(User).as_null_object }
  let(:friend) { mock_model(User) }
  
  describe "POST create" do
    before do
      controller.stub(:current_user).and_return(current_user)
    end
    
    it "should redirect to root path" do
      post :create
      response.should redirect_to root_path
    end
    
    it "requests a friendship with user" do
      current_user.should_receive(:request_friend).with(friend.id)
      post :create, :friend_id => friend.id
    end
  end
end
