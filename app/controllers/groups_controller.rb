class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy change_approval_system]

  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
  end

  def edit
    if current_user.id != @group.owner_id
      redirect_to groups_path, notice: 'あなたはこのグループのオーナーではありません。'
    end
  end

  def show
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.owner = current_user
    if params[:back]
      render :new
    else
      if @group.save
        @group.join_groups.create(user_id: current_user.id)
        redirect_to @group, notice: 'あなたのグループを作成しました。' 
      else
        render :new
      end
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: '修正しました'
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_group')
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: '投稿を削除しました' 
  end

  def change_approval_system
    if @group.approval_system == true
      @group.update(approval_system: 'false')
      redirect_to @group, notice: 'このグループへの参加が自由になりました。'
    else
      @group.update(approval_system: 'true')
      redirect_to @group, notice: 'このグループへの加入申請を許可制にしました。'
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
    params.require(:group).permit(:name, :introduction, :owner_id, :approval_system)
  end
end
