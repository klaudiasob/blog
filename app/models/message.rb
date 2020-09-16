# frozen_string_literal: true

class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, foreign_key: :sender_id, class_name: 'Owner'
  validates_presence_of :body, :conversation_id, :sender_id
  has_many :notifications, dependent: :destroy

  scope :with_unread_notifications, lambda { |conversation_id, recipient_id|
    joins(:notifications).where(conversation_id: conversation_id, notifications: { recipient_id: recipient_id, read: false })
  }
end
