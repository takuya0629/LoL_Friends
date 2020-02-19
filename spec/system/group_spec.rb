require 'rails_helper'

RSpec.describe 'グループ機能', type: :system do
  before do
      @user = FactoryBot.create(:user)
      @group = FactoryBot.create(:group, owner: @user)
      visit user_session_path
      fill_in 'Your name', with: @user.name
      fill_in 'Your password', with: @user.password
      click_button 'Sign in'
    end
  
  describe 'グループ登録画面' do
    context '正しく情報を入力しボタンを押した場合' do
      it 'グループが作成され、作成したグループ画面へ遷移する' do
        visit new_group_path

        fill_in 'グループ名', with: 'test'
        fill_in '内容', with: 'test'
        click_button 'グループ作成！'
        expect(page).to have_content 'グループを作成しました'
      end
    end
  end
end