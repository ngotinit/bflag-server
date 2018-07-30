class UserAppearsJob < ApplicationJob
  queue_as :urgent

  def perform(user)
    Redis.new.set("user_#{user.id}_online", "1")
    ActionCable.server.broadcast(
      'online_channel',
      user_id: current_user.id,
      online: true
    )
  end
end
