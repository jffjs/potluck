require 'spec_helper'

describe Group do
  describe "#private?" do
    it "returns true if group is private" do
      g = Factory(:group)
      g.private?.should == true
    end

    it "returns false if group is public" do
      g = Factory(:group, :privacy => 1)
      g.private?.should == false
    end
  end

  describe "#public?" do
    it "returns true if the group is public" do
      g = Factory(:group, :privacy => 1)
      g.public?.should == true
    end

    it "returns false if the group is private" do
      g = Factory(:group)
      g.public?.should == false
    end
  end

  describe "#visible_to?" do
    context "when the the group is public" do
      before do
        @g = Factory(:group, :privacy => 1)
        @u = Factory(:user)
      end

      it "returns true if the given user is not a member" do
        @g.visible_to?(@u).should == true
      end

      it "returns true if the given user is a member" do
        @g.members << @u
        @g.visible_to?(@u).should == true
      end
    end

    context "when the group is private" do
      before do
        @g = Factory(:group)
        @u = Factory(:user)
      end

      it "returns false if the given user is not a member" do
        @g.visible_to?(@u).should == false
      end

      it "returns true if the given user is a member" do
        @g.members << @u
        @g.visible_to?(@u).should == true
      end
    end
  end
end
