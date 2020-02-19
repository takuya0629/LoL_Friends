require 'rails_helper'

RSpec.describe '掲示板機能', type: :system do
  before do
      @user = FactoryBot.create(:user)
      @board = FactoryBot.create(:board, user: @user)
      visit user_session_path
      fill_in 'Your name', with: @user.name
      fill_in 'Your password', with: @user.password
      click_button 'Sign in'
    end
  

  describe 'スレッド登録画面' do
    context '正しく情報を入力しボタンを押した場合' do
      it 'スレッドが作成され、作成したスレッドへ遷移する' do
        visit new_board_path

        fill_in 'スレッド名', with: 'testboard'
        fill_in '内容', with: 'testboard'
        click_button 'スレッド作成！'
        expect(page).to have_content 'スレッドを作成しました'
      end
    end
  end

  describe 'スレッド一覧画面' do
    context '自分が作成した掲示板のdestroyボタンを押した場合' do
      it 'スレッドが削除され、一覧画面へ遷移する' do
        visit boards_path
        click_on 'Destroy'
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content 'スレッドを削除しました'
      end
    end
  end

  describe '任意のスレッド画面' do
    context 'コメントを書き込んだ場合' do
      it 'スレッド内にコメントが表示される' do
        visit board_path(@board)
        fill_in 'response-input', with: 'response-test'
        click_button '送信'

        expect(page).to have_content 'response-test'
      end
    end
  end
end
    #pageは画面上にあるかないか


