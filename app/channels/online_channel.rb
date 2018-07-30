class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "online_channel"
    appear
  end

  def unsubscribed
    disappear
  end

  private

  def appear
    UserAppearsJob.perform_later(current_user)
  end

  def disappear
    UserDisappearsJob.perform_later(current_user)
  end
end
