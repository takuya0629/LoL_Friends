class Response < ApplicationRecord
  belongs_to :board
  belongs_to :user

  validates :content, presence: :true

  def response_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
