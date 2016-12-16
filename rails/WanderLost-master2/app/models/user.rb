class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :inverse_messages, class_name: "Message", foreign_key: "recipient_id", dependent: :destroy
  has_many :blog_posts
  has_many :posts
  has_many :products

  def get_inbox
    self.inverse_messages
  end
  def get_sent
    self.messages
  end
  def request_friendship(user_2)
    self.friendships.create(friend: user_2)
  end

  def active_friends
    self.friendships.where(state: "active").map(&:friend) + self.inverse_friendships.where(state: "active").map(&:user)
  end

  def pending_friend_requests_from
    self.inverse_friendships.where(state: "pending").map(&:user)
  end

  def pending_friend_requests_to
    self.friendships.where(state: "pending").map(&:friend)
  end

  def friendship_status(user_2)
    friendship = Friendship.where(user_id: [self.id, user_2.id], friend_id: [self.id, user_2.id])

    if friendship.any? == false
      return "not_friends"
    elsif friendship.first.state == "active"
      return "friends"
    elsif friendship.first.user == self
      return "pending"
    elsif friendship.first.friend == self
      return "requested"
    end

  end

  def friendship_relation(user_2)
    Friendship.where(user_id: [self.id, user_2.id], friend_id: [self.id, user_2.id]).first
  end

end
