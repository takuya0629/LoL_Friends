class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy change_approval_system]

  def new
    @group = Group.new
  end

  def index
    @groups = Group.all.page(params[:page]).per(4)
  end

  def edit
    if current_user.id != @group.owner_id
      flash[:danger] = 'あなたはこのグループのオーナーではありません。'
      redirect_to groups_path 
    end
  end

  def show
    @join_group = JoinGroup.find_by(user_id: current_user, group_id: @group)
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.owner = current_user
    if params[:back]
      render :new
    else
      if @group.save
        @group.join_groups.create(user_id: current_user.id)
        flash[:success] = 'あなたのグループを作成しました。'
        redirect_to @group  
      else
        render :new
      end
    end
  end

  def update
    if @group.update(group_params)
      flash[:success] = '修正しました'
      redirect_to @group 
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_group')
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:success] = 'グループを削除しました'
    redirect_to groups_url 
  end

  def change_approval_system
    if @group.approval_system == true
      @group.update(approval_system: 'false')
      flash[:info] = 'このグループへの参加が自由になりました。'
      redirect_to @group
    else
      @group.update(approval_system: 'true')
      flash[:info] = 'このグループへの加入申請を許可制にしました。'
      redirect_to @group
    end
  end

  # def change_owner
  #   @assign = Assign.find(params[:format])
  #   @team.update(owner_id: @assign.user.id)
  #   ChangeOwnerMailer.change_owner_mail(@assign.user.email).deliver
  #   redirect_to team_path(@team), notice: 'オーナーを変更しました。'
  # end

  private
  def set_group
    @group = Group.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :approval_system, :icon)
  end
end
