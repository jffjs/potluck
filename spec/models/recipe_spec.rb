require 'spec_helper'

describe Recipe do

  describe "#private?" do
    it "returns true if recipe is private" do
      r = Factory(:recipe)
      r.private?.should == true
    end

    it "returns false if recipe is not private" do
      r = Factory(:recipe, :privacy => 1)
      r.private?.should == false
    end
  end

  describe "#public?" do
    it "returns true if recipe is public" do
      r = Factory(:recipe, :privacy => 1)
      r.public?.should == true
    end

    it "returns false is recipe is not public" do
      r = Factory(:recipe)
      r.public?.should == false
    end
  end

  describe "#visible_to?" do
    context "when the recipe is public" do
      it "returns true if the given user does not own the recipe" do
        r = Factory(:recipe, :user => Factory(:user), :privacy => 1)
        other = Factory(:user)
        r.visible_to?(other).should == true
      end

      it "returns true if the given user is the recipe owner" do
        u = Factory(:user)
        r = Factory(:recipe, :user => u, :privacy => 1)
        r.visible_to?(u).should == true
      end
    end

    context "when the recipe is private" do
      it "returns false if the given user does not own the recipe" do
        r = Factory(:recipe, :user => Factory(:user))
        other = Factory(:user)
        r.visible_to?(other).should == false
      end

      it "returns true if the given user owns the recipe" do
        u = Factory(:user)
        r = Factory(:recipe, :user => u)
        r.visible_to?(u).should == true
      end
    end
  end
end
