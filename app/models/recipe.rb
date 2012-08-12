class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :shared_recipes, :dependent => :destroy
  has_many :groups, :through => :shared_recipes
  has_many :ingredients, :class_name => 'RecipeIngredient'

  accepts_nested_attributes_for :ingredients
  validates :name, :presence => true

  def public?
    self.privacy == 1
  end

  def private?
    self.privacy == 0
  end

  def visible_to?(user)
    self.public? || self.user == user
  end
end
