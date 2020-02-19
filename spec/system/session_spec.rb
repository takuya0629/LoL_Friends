require 'rails_helper'

RSpec.describe 'ログイン機能', type: :system do
  before do 
    @user = FactoryBot.create(:user)
  end

  

  describe 'ログイン画面' do
    context '正しくユーザ情報を入力しボタンを押した場合' do
      it 'ログインされマイページへ遷移する' do
        visit user_session_path
        fill_in 'Your name', with: @user.name
        fill_in 'Your password', with: @user.password
        click_button 'Sign in'

        expect(page).to have_content "#{@user.name}さんのマイページです。"
        expect(page).to have_content "ログインしました。"
      end
    end
    context 'ログアウトボタンを押した場合' do
      it 'ログアウトされ、トップページへ遷移する' do
        visit user_session_path
        fill_in 'Your name', with: @user.name
        fill_in 'Your password', with: @user.password
        click_button 'Sign in'

        click_link 'ログアウト'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "ログアウトしました。"
      end
    end
  end
end
    #pageは画面上にあるかないか


