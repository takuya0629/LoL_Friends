class Group < ApplicationRecord
  has_many :join_groups, dependent: :destroy
  has_many :join_group_users, through: :join_groups, source: :user
  has_many :judgements, dependent: :destroy

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
end
