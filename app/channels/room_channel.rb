class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}"
  end

  def unsubscribed; end

  def send_data(args)
    message = args['message']
    current_user.messages.create!(
      content: message[:content],
      room_id: message[:room_id]
    )
  end
end
