class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'Owner'
  validates_presence_of :body, :conversation_id, :sender_id
  has_many :notifications, dependent: :destroy

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end