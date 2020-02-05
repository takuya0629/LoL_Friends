class JudgementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[create]

  def create
    if @group.join_group_users.find_by(id: current_user.id)
      flash[:warning] = 'あなたは加入申請済です'
      redirect_to @group
    else
      @group.judgements.create(user_id: current_user.id)
      JoinGroupMailer.join_group_mail(@group.owner.email, current_user, @group, @group.judgements.find_by(user_id: current_user)).deliver
      flash[:success] = 'オーナーへ加入申請を送信しました'
      redirect_to @group
    end
  end

  def join_group_permission
    @group = Judgement.find(params[:id]).group
    @user = Judgement.find(params[:id]).user
    @group.join_groups.create(user_id: Judgement.find(params[:id]).user_id)
    flash[:success] = '加入を許可しました'
    redirect_to @group

    JoinGroupJudgmentMailer.join_group_judgment_mail(@user, @group).deliver
    Judgement.find(params[:id]).destroy
  end

  def join_group_deny
    @user = Judgement.find(params[:id]).user
    @group = Judgement.find(params[:id]).group
    flash[:info] = '参加をお断りしました'
    redirect_to @group

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