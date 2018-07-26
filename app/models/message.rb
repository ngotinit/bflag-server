class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :broadcast_message

  def self.get_history(size=10, offset)
    all.order(created_at: :desc).limit(size).offset(offset)
  end

  private

  def broadcast_message
    MessageBroadcastJob.perform_later(self)
  end
end
