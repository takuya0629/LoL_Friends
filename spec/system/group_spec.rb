require 'rails_helper'

RSpec.describe 'グループ機能', type: :system do
  before do
    @user2 = FactoryBot.create(:user2)
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

  describe 'グループ詳細画面' do 
    context '設定を変更し、ボタンを押した場合場合' do 
      it '変更内容が反映される' do
        visit edit_group_path(@group)
        fill_in 'グループ名', with: 'testaaaaaaaaaaa'
        fill_in 'グループの説明', with: 'testaaaaaaaaaaa'
        click_button '設定を変更する'

        expect(page).to have_content 'testaaaaaaaaaaa'
      end
    end

    context '削除ボタンを押した場合' do 
      it 'グループが削除される' do 
        visit edit_group_path(@group)
        click_link '削除'
        page.driver.browser.switch_to.alert.accept
        sleep 5

        expect(page).to have_content 'グループを削除しました'
      end
    end

    context 'グループに参加する場合' do 
      it '自由参加型グループなら、グループへ参加する' do 
        @group2 = FactoryBot.create(:group, owner: @user2, name: 'test2')
        visit group_path(@group2)
        click_link '参加する'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'グループへ参加しました'
      end

      it '承認制グループなら加入申請を送信する' do
        @group3 = FactoryBot.create(:approval_group, owner: @user2)
        visit group_path(@group3)
        click_link '加入申請をする'
        
        
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'オーナーへ加入申請を送信しました'
      end
    end
  end
end



# current_user, @group, @group.judgements.find_by(user_id: current_user)








