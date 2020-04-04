# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'Owner'
  belongs_to :message

  validates :recipient_id, :message_id, presence: true
end
