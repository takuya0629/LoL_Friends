require 'rails_helper'

RSpec.describe '掲示板登録', type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  
  it 'titleが空ならバリデーションが通らない' do
    board = Board.new(title: '', content: 'test', user_id: @user.id )
    expect(board).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    board = Board.new(title: 'test', content: '', user_id: @user.id )
    expect(board).not_to be_valid
  end

  it 'user_idが空ならバリデーションが通らない' do
    board = Board.new(title: 'test', content: 'test', user_id: '' )
    expect(board).not_to be_valid
  end

  it '問題なく登録できる' do
    board = Board.new(title: 'test', content: 'test', user_id: @user.id )
    expect(board).to be_valid
  end
end