require 'rails_helper'

RSpec.describe 'グループメッセージテスト', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group, owner: @user)
  end
  
  it 'group_idが空ならバリデーションが通らない' do
    @group_message = GroupMessage.new(group_id: '', user_id: @user.id, content: 'test')
    expect(@group_message).not_to be_valid
  end

  it 'user_idが空ならバリデーションが通らない' do
    @group_message = GroupMessage.new(group_id: @group.id, user_id: '', content: 'test')
    expect(@group_message).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    @group_message = GroupMessage.new(group_id: @group.id, user_id: '', content: '')
    expect(@group_message).not_to be_valid
  end

  it '問題なく登録できる' do
    @group_message = GroupMessage.new(group_id: @group.id, user_id: @user.id, content: 'test')
    expect(@group_message).to be_valid
  end
end