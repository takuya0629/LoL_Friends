class JudgementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[create]

  def create
    if @group.join_group_users.find_by(id: current_user.id)
      redirect_to @group, notice: 'あなたは加入申請済です'
    else
      @group.judgements.create(user_id: current_user.id)
      JoinGroupMailer.join_group_mail(@group.owner.email, current_user, @group, @group.judgements.find_by(user_id: current_user)).deliver
      redirect_to @group, notice: 'オーナーへ加入申請を送信しました'
    end
  end

  def join_group_permission
    @group = Judgement.find(params[:id]).group
    @user = Judgement.find(params[:id]).user
    @group.join_groups.create(user_id: Judgement.find(params[:id]).user_id)
    redirect_to @group, notice: '加入を許可しました'

    JoinGroupJudgmentMailer.join_group_judgment_mail(@user, @group).deliver
    Judgement.find(params[:id]).destroy
  end

  def join_group_deny
    @user = Judgement.find(params[:id]).user
    @group = Judgement.find(params[:id]).group
    redirect_to @group, notice: '参加をお断りしました'

    JoinGroupJudgmentMailer.join_group_judgment_mail(@user, @group).deliver
    Judgement.find(params[:id]).destroy
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_params
    params.require(:judgements).permit(:group_id, :user_id)
  end
end

# @group.judgements.find(user_id: current_user)