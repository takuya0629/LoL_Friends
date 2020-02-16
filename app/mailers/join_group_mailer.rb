class JoinGroupMailer < ApplicationMailer
  default from: 'from@example.com'

   def join_group_mail(email, current_user, group, id)
    @email = email
    @user = current_user
    @group = group
    @id = id

    mail to: @email, subject: 'あなたのグループへ加入申請が届きました。'
  end
end
