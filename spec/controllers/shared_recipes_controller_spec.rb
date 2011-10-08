require 'spec_helper'

describe SharedRecipesController do
  describe 'POST create' do
    let(:shared_recipe) { mock_model(SharedRecipe).as_null_object }

    before do
      SharedRecipe.stub(:new).and_return(shared_recipe)
      @attr = { 'recipe_id' => '1',
                'group_id'  => '1' }
    end

    it "creates a new shared_recipe" do
      SharedRecipe.should_receive(:new).with(@attr).and_return(shared_recipe)
      post :create, :shared_recipe => @attr
    end

    it "saves the shared_recipe" do
      shared_recipe.should_receive(:save)
      post :create, :shared_recipe => @attr
    end

    context "when the recipe is shared successfully" do
      before do
        shared_recipe.stub(:save).and_return(true)
      end

      it "should redirect to the shared recipe's show path" do
        post :create, :shared_recipe => @attr
        response.should redirect_to recipe_path(@attr['recipe_id'])
      end
    end
  end
end
