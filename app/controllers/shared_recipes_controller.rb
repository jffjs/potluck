class SharedRecipesController < ApplicationController
  def create
    shared_recipe = SharedRecipe.new(params[:shared_recipe])
    shared_recipe.save
    redirect_to recipe_path(params[:shared_recipe][:recipe_id])
  end
end
