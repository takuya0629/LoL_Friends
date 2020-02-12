class GroupMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def index
    @group_messages = @group.group_messages.order(:created_at)
    gon.current_user = current_user
    gon.group = @group
    gon.avater = current_user.avater

    if @group_messages.length > 10

      @over_ten = true
      # @group_messages = @group_message.where(id: @group_messages.last(10).map{|msg| msg.id})
      @group_messages = @group_messages.where(id: @group_messages[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @group_messages = @group.group_messages
    end

    @group_messages = @group.group_messages.order(:created_at)
    @group_message = @group.group_messages.build

  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_message_params
    params.require(:group_message).permit(:content, :user_id, :image)
  end
end
