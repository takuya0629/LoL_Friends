class JoinGroupJudgmentMailer < ApplicationMailer
default from: 'from@example.com'

   def join_group_judgment_mail(email, name)
    @email = email
    @name = name
    mail to: @email, subject: '結果'
  end
end
