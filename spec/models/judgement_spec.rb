require 'rails_helper'

RSpec.describe 'グループ参加判断テスト', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @group = FactoryBot.create(:group, owner: @user)
  end
  
  it 'group_idが空ならバリデーションが通らない' do
    @judgements = Judgement.new(group_id: '', user_id: @user.id)
    expect(@judgements).not_to be_valid
  end

  it 'user_idが空ならバリデーションが通らない' do
    @judgements = Judgement.new(group_id: @group.id, user_id: '')
    expect(@judgements).not_to be_valid
  end

  it '問題なく登録できる' do
    @judgements = Judgement.new(group_id: @group.id, user_id: @user.id)
    expect(@judgements).to be_valid
  end
end