class Group < ApplicationRecord
  has_one_attached :icon
  has_many :join_groups, dependent: :destroy
  has_many :join_group_users, through: :join_groups, source: :user
  has_many :judgements, dependent: :destroy
  has_many :group_messages, dependent: :destroy

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  validates :name, presence: :true, uniqueness: true, length: { maximum: 25 } 
  validates :introduction, presence: :true, length: { maximum: 75 } 
end
