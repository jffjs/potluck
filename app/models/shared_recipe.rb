class SharedRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :group
end
