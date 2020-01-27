class Response < ApplicationRecord
  belongs_to :board
  belongs_to :users
end
