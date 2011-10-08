class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :recipes
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :owned_groups, :class_name => 'Group', :foreign_key => 'owner_id'
  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
  has_many :requested_friends, :through => :friendships, 
                               :source => :friend, 
                               :conditions => "status = 'requested'"
  has_many :pending_friends,   :through => :friendships, 
                               :source => :friend, 
                               :conditions => "status = 'pending' and ignored = 'f'"
  has_many :ignored_pending_friends,  :through => :friendships,
                                      :source => :friend,
                                      :conditions => "status = 'pending' and ignored = 't'"
  has_many :friendships, :dependent => :destroy

  validates :name, :presence => :true

  def request_friend(friend)
    Friendship.create!(:user => self, :friend => friend, :status => 'requested',
                                                         :ignored => false)
    Friendship.create!(:user => friend, :friend => self, :status => 'pending',
                                                         :ignored => false)
  end

  def accept_friend(friend)
    friendships.first(:conditions => { :user_id => self, :friend_id => friend })
      .update_attributes(:status => 'accepted')
    friend.friendships.first(:conditions => { :user_id => friend, :friend_id => self })
      .update_attributes(:status => 'accepted')
  end

  def ignore_friend_request(friend)
    friendship = Friendship.first(:conditions => { :user_id => self, :friend_id => friend })
    friendship.update_attributes(:ignored => true)
  end

  def remove_friend(friend)
    friendships.destroy(Friendship.first(:conditions => { :user_id => self,
                                                          :friend_id => friend }))
    friend.friendships.destroy(Friendship.first(:conditions => { :user_id => friend,
                                                                 :friend_id => self }))                                                
  end
end
