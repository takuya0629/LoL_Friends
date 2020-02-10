class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data['message'], conversation_id: data['conversation_id'], user_id: data['current_user']['id'])
    current_user = data['current_user']
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message, current_user: data['current_user']})
    ActionCable.server.broadcast 'room_channel', template
  end
end