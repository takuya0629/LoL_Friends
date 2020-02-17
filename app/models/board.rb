class Board < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy

  validates :title, presence: :true, uniqueness: true, length: { maximum: 25 } 
  validates :content, presence: :true, length: { maximum: 75 } 
end
