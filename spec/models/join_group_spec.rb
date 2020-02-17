require 'rails_helper'

RSpec.describe 'グループ参加テスト', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group, owner: @user)
  end
  
  it 'group_idが空ならバリデーションが通らない' do
    @join_group = JoinGroup.new(group_id: '', user_id: @user.id)
    expect(@join_group).not_to be_valid
  end

  it 'user_idが空ならバリデーションが通らない' do
    @join_group = JoinGroup.new(group_id: @group.id, user_id: '')
    expect(@join_group).not_to be_valid
  end

  it '問題なく登録できる' do
    @join_group = JoinGroup.new(group_id: @group.id, user_id: @user.id)
    expect(@join_group).to be_valid
  end
end