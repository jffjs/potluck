class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
  has_many :requested_friends, :through => :friendships, 
                               :source => :friend, 
                               :conditions => "status = 'requested'"
  has_many :pending_friends,   :through => :friendships, 
                               :source => :friend, 
                               :conditions => "status = 'pending'"
  has_many :friendships, :dependent => :destroy
  
  validates :name, :presence => :true
  
  def request_friend(friend_id)
    friend = User.find(friend_id)
    Friendship.create!(:user => self, :friend => friend, :status => 'requested')
    Friendship.create!(:user => friend, :friend => self, :status => 'pending')
  end
end
