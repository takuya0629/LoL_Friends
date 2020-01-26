class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data['message'], conversation_id: data['conversation_id'], user_id: data['user_id'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message, user_id: data['user_id']})
    ActionCable.server.broadcast 'room_channel', template
  end
end