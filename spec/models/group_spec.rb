require 'rails_helper'

RSpec.describe 'グループ登録', type: :model do
  before do
    @user = FactoryBot.create(:user)
    # @user = create(:user)
  end
  
  it 'nameが空ならバリデーションが通らない' do
    group = Group.new(name: '', introduction: 'test', owner_id: @user.id )
    expect(group).not_to be_valid
  end

  it 'introductionが空ならバリデーションが通らない' do
    group = Group.new(name: 'test', introduction: '', owner_id: @user.id )
    expect(group).not_to be_valid
  end

  it 'owner_idが空ならバリデーションが通らない' do
    group = Group.new(name: 'test', introduction: 'test', owner_id: '' )
    expect(group).not_to be_valid
  end

  it '問題なく登録できる' do
    group = Group.new(name: 'test', introduction: 'test', owner_id: @user.id )
    expect(group).to be_valid
  end
end