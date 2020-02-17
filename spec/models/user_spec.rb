require 'rails_helper'

RSpec.describe 'ユーザ登録', type: :model do
  
  it 'nameが空ならバリデーションが通らない' do
    user = User.new(name: '', email: 'test@aa.aa', password: 'password' )
    expect(user).not_to be_valid
  end

  it 'emailが空ならバリデーションが通らない' do
    user = User.new(name: 'test', email: '', password: 'password' )
    expect(user).not_to be_valid
  end

  it '問題なく登録できる' do
    user = User.new(name: 'test', email: 'test@aa.aa', password: 'password' )
    expect(user).to be_valid
  end
end