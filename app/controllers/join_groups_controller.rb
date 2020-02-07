class JoinGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: :create

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

  def destroy
    # @join_group = current_user.join_groups.find_by(group_id: @group)
    @join_group = JoinGroup.find(params[:id])
    @join_group.destroy

    flash[:warning] = 'グループを脱退しました。'
      redirect_to groups_path
  end
  
  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_params
    params.require(:join_group).permit(:group_id, :approve)
  end
end


