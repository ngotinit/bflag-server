class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}"
  end

  def unsubscribed; end

  def send_data(args)
    current_user.messages.create!(
      content: args['content'],
      room_id: params[:room_id]
    )
  end
end
