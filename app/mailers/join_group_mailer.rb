class JoinGroupMailer < ApplicationMailer
  default from: 'from@example.com'

   def join_group_mail(email, name)
    @email = email
    @name = name
    mail to: @email, subject: 'あなたのグループへ加入申請が届きました。'
  end
end
