require 'rails_helper'

RSpec.describe 'ユーザ機能', type: :system do
  

  describe '新規ユーザ登録画面' do
    context '正しくユーザ情報を入力しボタンを押した場合' do
      it 'ユーザが作成され、ログインページへ遷移する' do
        visit new_user_registration_path

        fill_in 'Your name', with: 'aaa'
        fill_in 'Your email', with: 'aaa@aa.aa'
        fill_in 'Your password', with: 'testtest'
        fill_in 'Password Confirmation', with: 'testtest'
        click_button 'Send'

        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end
    end
  end

  context 'ユーザログイン時の処理' do
    before do
      @user = FactoryBot.create(:user)
      visit user_session_path
      fill_in 'Your name', with: @user.name
      fill_in 'Your password', with: @user.password
      click_button 'Sign in'
    end

    context 'ユーザ情報を編集した場合' do
      it '編集され、マイページへ遷移する' do  
        visit edit_user_registration_path
        fill_in 'プロフィール', with: 'testtest'
        fill_in '現在のパスワード', with: @user.password
        click_on '設定を変更する'

        expect(page).to have_content 'マイページです'
        expect(page).to have_content 'testtest'
      end
    end

    context 'ユーザ情報を削除した場合' do
      it '削除され、トップページへ遷移する' do  
        visit edit_user_registration_path
        click_on 'アカウント削除'
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end
    end
  end
end
    #pageは画面上にあるかないか


