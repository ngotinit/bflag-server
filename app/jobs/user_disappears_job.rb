class UserDisappearsJob < ApplicationJob
  queue_as :urgent

  def perform(user)
    Redis.new.del("user_#{user.id}_online")
    ActionCable.server.broadcast(
      'online_channel',
      user_id: current_user.id,
      online: false
    )
  end
end
