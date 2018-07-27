class OnlineChannel < ApplicationCable::Channel
  def subscribed
    redis.set("user_#{current_user.id}_online", "1")
    stream_from "online_channel"
    ActionCable.server.broadcast(
      "online_channel",
      user_id: current_user.id,
      online: true
    )
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_online")
    ActionCable.server.broadcast(
      "online_channel",
      user_id: current_user.id,
      online: false
    )
  end

  private

  def redis
    Redis.new
  end
end
