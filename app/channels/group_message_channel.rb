class GroupMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    group_message = GroupMessage.create!(content: data['message'], group_id: data['group_id'], user_id: data['current_user']['id'])
    current_user = data['current_user']
    template = ApplicationController.renderer.render(partial: 'group_messages/group_message', locals: {message: message, current_user: current_user})
    ActionCable.server.broadcast 'group_message_channel', template
  end
end


