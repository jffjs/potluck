class CreateSharedRecipes < ActiveRecord::Migration
  def change
    create_table :shared_recipes do |t|
      t.integer :group_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
