class MessagesController < ApplicationController
  before_action :set_conversasion, only: %i[index create]

  def index
    @messages = @conversation.messages.order(:created_at)
    gon.current_user = current_user
    gon.conversation = @conversation
    gon.avater = current_user.avater


    if @messages.length > 10
      @over_ten = true
      @messages = Message.where(id: @messages[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      @messages.where.not(user_id: current_user.id).update_all(read: true)
    end

    @messages = @messages.order(:created_at)
    @message = @conversation.messages.build

  end

  # 現状非同期処理なので、createは必要ない
  # def create
  #   @message = @conversation.messages.build(message_params)
  #   if @message.save
  #     redirect_to conversation_messages_path(@conversation)
  #   else
  #     redirect_to conversation_messages_path
  #   end
  # end

  def destroy
    @message = Message.find(params[:id])
    conversation = @message.conversation
    @message.destroy
    redirect_to conversation_messages_path(conversation), notice: '投稿を削除しました'
  end

  private

  def set_conversasion
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id, :image)
  end
end
