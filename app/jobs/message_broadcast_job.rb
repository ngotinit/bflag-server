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
      friend: {
        email: message.user.email,
        username: message.user.username,
        profile_image: message.user.profile_image.url
      },
      message: {
        content: message.content,
        img_url: nil
      },
      time: message.created_at.localtime
    }.to_json
  end
end
