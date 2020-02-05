class JoinGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    if @group.join_group_users.find_by(id: current_user.id)
      flash[:warning] = 'あなたは参加済です'
      redirect_to @group
    elsif @group.approval_system == false
      @group.join_groups.create(user_id: current_user.id)
      flash[:warning] = 'グループへ参加しました'
      redirect_to @group
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


