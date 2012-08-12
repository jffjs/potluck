class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @index = 3
    @index.times do
      @recipe.ingredients << RecipeIngredient.new
    end
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @groups = current_user.groups - @recipe.groups if user_signed_in?
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
end
