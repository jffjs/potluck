require 'spec_helper'

describe RecipesController do
  describe "GET new" do

    it "creates an empty recipe" do
      Recipe.should_receive(:new)
      get :new
    end

    it "should render the 'new' template" do
      get :new
      response.should render_template('new')
    end

    it "assigns @recipe" do
      get :new
      assigns[:recipe].should_not be_nil
    end
  end

  describe "POST create" do
    let(:recipe) { mock_model(Recipe).as_null_object }

    before do
      Recipe.stub(:new).and_return(recipe)
      @attr = { 'name' => "Recipe",
                'description' => "Recipe desc",
                'preparation' => "Add this to that" }
    end

    it "creates a new recipe" do
      Recipe.should_receive(:new).with(@attr).and_return(recipe)
      post :create, :recipe => @attr
    end

    it "saves the recipe" do
      recipe.should_receive(:save)
      post :create, :recipe => @attr
    end

    context "when the recipe saves successfully" do
      before do
        recipe.stub(:save).and_return(true)
      end

      it "should redirect to the new recipe's show path" do
        post :create, :recipe => @attr
        response.should redirect_to recipe_path(recipe)
      end
    end

    context "when the recipe fails to save" do
      before do
        recipe.stub(:save).and_return(false)
      end

      it "assigns @recipe" do
        post :create
        assigns[:recipe].should == recipe
      end

      it "should render the 'new' template" do
        post :create
        response.should render_template('new')
      end
    end
  end

  describe "GET show" do
    let(:recipe) { mock_model(Recipe).as_null_object }

    it "finds the requested recipe" do
      Recipe.should_receive(:find).with(recipe.id.to_s).and_return(recipe)
      get :show, :id => recipe.id
    end

    it "assigns @recipe" do
      Recipe.stub(:find).and_return(recipe)
      get :show, :id => recipe.id
      assigns[:recipe].should == recipe
    end
  end

  describe "GET index" do
    it "displays a list of recipes" do
      Recipe.should_receive(:all)
      get :index
    end
  end
end
