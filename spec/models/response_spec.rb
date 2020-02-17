require 'rails_helper'

RSpec.describe 'フォローフォロワーテスト', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @board = FactoryBot.create(:board, user: @user)
  end
  
  it 'user_idが空ならバリデーションが通らない' do
    response = Response.new(user_id: '', content: 'aaaaaa', board_id: @board.id )
    expect(response).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    response = Response.new(user_id: @user.id, content: '', board_id: @board.id )
    expect(response).not_to be_valid
  end

  it 'board_id
  が空ならバリデーションが通らない' do
    response = Response.new(user_id: @user.id, content: 'aaaaaa', board_id: '' )
    expect(response).not_to be_valid
  end

  it '問題なく登録できる' do
    response = Response.new(user_id: @user.id, content: 'aaaaaa', board_id: @board.id )
    expect(response).to be_valid
  end
end