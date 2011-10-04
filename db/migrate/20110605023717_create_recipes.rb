class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string  :name
      t.string  :description
      t.text    :preparation
      t.integer :yields
      t.integer :cooking_time_hours
      t.integer :cooking_time_minutes
      t.timestamps
    end
  end
end
