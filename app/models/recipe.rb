class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :shared_recipes, :dependent => :destroy
  has_many :groups, :through => :shared_recipes
end
