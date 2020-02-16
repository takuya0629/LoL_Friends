class JoinGroupJudgmentMailer < ApplicationMailer
default from: 'from@example.com'

   def join_group_judgment_mail(user, group)
    @user = user
    @email = @user.email
    @group = group
    mail to: @email, subject: 'グループ参加申請の結果です'
  end
end
