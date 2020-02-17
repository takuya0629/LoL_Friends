class GroupMessage < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :content, presence:  { message: 'メッセージを入力してください' }

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
