
require 'rails_helper'

RSpec.describe 'フォローフォロワーテスト', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
  end
  
  it 'follower_idが空ならバリデーションが通らない' do
    relationship = Relationship.new(follower_id: '', followed_id: @user.id )
    expect(relationship).not_to be_valid
  end

  it 'followed_idが空ならバリデーションが通らない' do
    relationship = Relationship.new(follower_id: @user2.id, followed_id: '' )
    expect(relationship).not_to be_valid
  end

  it '問題なく登録できる' do
    relationship = Relationship.new(follower_id: @user2.id, followed_id: @user.id )
    expect(relationship).to be_valid
  end
end
