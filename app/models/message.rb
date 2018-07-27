class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :broadcast_message

  def self.get_history(room_id, offset, size=10)
    where(room_id: room_id).order(created_at: :desc).limit(size).offset(offset)
  end

  private

  def broadcast_message
    MessageBroadcastJob.perform_later(self)
  end
end
