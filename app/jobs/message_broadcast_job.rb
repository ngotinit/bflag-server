class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "room_#{message.room_id}",
      message: render_message(message)
    )
  end

  private

  def render_message(message)
    message.to_json
  end
end
