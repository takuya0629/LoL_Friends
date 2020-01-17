class JoinGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    if @group.approve == 'true'
      JoinGroupMailer.join_group_mail(@group.owner.email, current_user.name).deliver
      redirect_to @group, notice: '加入申請が完了しました。'
    elsif @group.join_group_users.find_by(id: current_user.id)
      redirect_to @group, notice: 'あなたは参加済です'
    else
      @group.join_groups.create(user_id: current_user.id)
      redirect_to @group, notice: 'グループへ参加しました'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_params
    params.require(:join_group).permit(:group_id, :approve)
  end
end


