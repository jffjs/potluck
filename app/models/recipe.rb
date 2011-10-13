class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :shared_recipes, :dependent => :destroy
  has_many :groups, :through => :shared_recipes

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
