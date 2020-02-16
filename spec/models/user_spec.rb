require 'rails_helper'

RSpec.describe 'ユーザ登録', type: :model do
  
  it 'nameが空ならバリデーションが通らない' do
    user = User.new(name: 'aa', email: 'test@aa.aa', password: 'test' )
    expect(user).not_to be_valid
  end
end