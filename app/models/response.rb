class Response < ApplicationRecord
  belongs_to :board
  belongs_to :user

  def response_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
