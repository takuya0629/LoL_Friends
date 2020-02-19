require 'rails_helper'

RSpec.describe 'メッセージ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    @conversation = FactoryBot.create(:conversation, sender: @user, recipient: @user2)
    visit user_session_path
    fill_in 'Your name', with: @user.name
    fill_in 'Your password', with: @user.password
    click_button 'Sign in'
  end
  
  describe 'メッセージ画面' do

    context '情報を入力しボタンを押した場合' do
      it 'メッセージが表示され、削除ボタンを押したら削除される' do
        visit user_path(@user2)
        click_link 'メッセージを送る'
        fill_in 'chat-input', with: 'test-message'
        click_button '送信'
        expect(page).to have_content 'test-message'
        click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'test-message'
      end
    end
  end
end


