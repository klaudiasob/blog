# frozen_string_literal: true

class Conversation < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: 'Owner'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'Owner'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :between, lambda { |sender_id, recipient_id|
    where('(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)', sender_id, recipient_id, recipient_id, sender_id)
  }

  def unread_notifications(recipient_id)
    messages.joins(:notifications).where(notifications: { recipient_id: recipient_id, read: false })
  end
end
