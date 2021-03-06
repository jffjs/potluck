require 'spec_helper'

describe User do
  describe "validations" do
    let(:user) { User.new(:name => "Jeff",
                          :email => "user@test.com",
                          :password => "password",
                          :password_confirmation => "password")}

    it "is valid with valid attributes" do
      user.should be_valid
    end

    it "is not valid without a name" do
      user.name = nil
      user.should_not be_valid
    end

    it "is not valid without email" do
      user.email = nil
      user.should_not be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      user.should_not be_valid
    end

    it "should have a password and password confirmation" do
      user.password = "different"
      user.should_not be_valid
    end
  end
  describe "friendship methods" do
    before do
      @user = Factory.create(:user)
      @friend = Factory.create(:friend)
    end

    describe "#request_friend" do
      it "requests friendship with another user" do
        @user.request_friend(@friend)
        @user.requested_friends.should == [@friend]
        @friend.pending_friends.should == [@user]
      end
    end

    describe "#accept_friend" do
      it "accepts friendship with a user that has requested friendship" do
        @friend.request_friend(@user)
        @user.accept_friend(@friend)
        @user.friends.should == [@friend]
        @friend.friends.should == [@user]
      end
    end

    describe "#ignore_friend_request" do
      it "sets the user's pending friendship request to ignored" do
        @friend.request_friend(@user)
        @user.ignore_friend_request(@friend)
        @user.pending_friends.should_not include(@friend)
      end
    end

    describe "#remove_friend" do
      it "removes the friendship with the passed user" do
        @user.request_friend(@friend)
        @friend.accept_friend(@user)
        @user.friends.should include(@friend)
        @user.remove_friend(@friend)
        @user.reload
        @user.friends.should_not include(@friend)
      end
    end
  end
end
