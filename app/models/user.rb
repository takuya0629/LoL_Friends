class User < ApplicationRecord
  has_one_attached :avater
  has_many :boards, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :join_groups, dependent: :destroy
  has_many :users_in_groups, through: :join_groups, source: :group
  has_many :groups, foreign_key: :owner_id
  has_many :judgements, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :sender_conversations, class_name: 'Conversation', foreign_key: 'sender_id', dependent: :destroy
  has_many :recipient_conversations, class_name: 'Conversation', foreign_key: 'recipient_id', dependent: :destroy
  has_many :group_messages, dependent: :destroy

  validates :name, presence: :true, uniqueness: { case_sensitive: false }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable,
         authentication_keys: [:login]
  
  attr_writer :login

  def login
    @login || self.name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:name) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  #フォローしているかどうかを確認する
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end