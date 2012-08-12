class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.string :amount
      t.string :measurement
      t.string :raw
      t.integer :recipe_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
