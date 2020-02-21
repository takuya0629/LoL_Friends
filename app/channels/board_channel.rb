class BoardChannel < ApplicationCable::Channel
  def subscribed
    stream_from "board_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    response = Response.create!(content: data['response'], board_id: data['board_id'], user_id: data['user_id'])
    template = ApplicationController.renderer.render(partial: 'responses/response', locals: {response: response, current_user: data['current_user']})
    ActionCable.server.broadcast 'board_channel', template
  end
end
