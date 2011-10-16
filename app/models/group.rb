class Group < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :memberships
  has_many :members, :through => :memberships, :source => :user
  has_many :shared_recipes, :dependent => :destroy
  has_many :recipes, :through => :shared_recipes

  def public?
    self.privacy == 1
  end

  def private?
    self.privacy == 0
  end

  def visible_to?(user)
    self.public? || self.members.include?(user)
  end
end
