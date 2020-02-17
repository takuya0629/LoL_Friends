require 'rails_helper'

RSpec.describe 'conversaionテスト', type: :model do
  before do
    @sender = FactoryBot.create(:user)
    @recipient = FactoryBot.create(:user2)
  end
  
  it 'sender_idが空ならバリデーションが通らない' do
    @conversaion = Conversation.new(sender_id: '', recipient_id: @recipient.id)
    expect(@conversaion).not_to be_valid
  end

  it 'recipient_idが空ならバリデーションが通らない' do
    @conversaion = Conversation.new(sender_id: @sender.id, recipient_id: '')
    expect(@conversaion).not_to be_valid
  end

  it '問題なく登録できる' do
    @conversaion = Conversation.new(sender_id: @sender.id, recipient_id: @recipient.id)
    expect(@conversaion).to be_valid
  end
end