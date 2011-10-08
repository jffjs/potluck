require 'spec_helper'

describe UsersController do
  describe "GET show" do
    let(:user) { mock_model(User)}

    before do
      User.stub(:find).and_return(user)
    end

    it "should be successful" do
      get :show, :id => user
      response.should be_success
    end

    it "should show the requested user" do
      get :show, :id => user
      assigns(:user).should == user
    end
  end
end
