class AddPrivacyColumnToRecipesTable < ActiveRecord::Migration
  def change
    add_column :recipes, :privacy, :integer
  end
end
