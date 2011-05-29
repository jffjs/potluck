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
  
  describe "#request_friend" do
    it "requests friendship with another user" do
      user = Factory.create(:user)
      friend = Factory.create(:friend)
      user.request_friend(friend.id)
      user.requested_friends.should == [friend]
      friend.pending_friends.should == [user]
    end
  end
end
