class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "room_#{message.room_id}",
      render_message(message)
    )
  end

  private

  def render_message(message)
    {
      user: message.user.username,
      room_id: message.room_id,
      content: message.content
    }.to_json
  end
end
