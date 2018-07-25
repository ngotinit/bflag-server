class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}"
  end

  def unsubscribed; end

  def send_data(args)
    content = args['content']
    current_user.messages.create!(
      content: content,
      room_id: params[:room_id]
    )
  end
end
