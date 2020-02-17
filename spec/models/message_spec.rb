require 'rails_helper'

RSpec.describe 'メッセージテスト', type: :model do

  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    @conversation = FactoryBot.create(:conversation, sender: @user, recipient: @user2)
  end
  
  it 'contentが空ならバリデーションが通らない' do
    @message = Message.new(content: '', conversation_id: @conversation.id, user_id: @user.id)
    expect(@message).not_to be_valid
  end

  it 'user_idが空ならバリデーションが通らない' do
    @message = Message.new(content: '', conversation_id: '', user_id: @user.id)
    expect(@message).not_to be_valid
  end

  it '問題なく登録できる' do
    @message = Message.new(content: 'aaaa', conversation_id: @conversation.id, user_id: @user.id)
    expect(@message).to be_valid
  end
end
