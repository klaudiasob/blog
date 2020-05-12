# frozen_string_literal: true

module MessageServices
  class Create
    attr_reader :params, :conversation, :owner

    def initialize(params, conversation, owner)
      @params = params
      @conversation = conversation
      @owner = owner
    end

    def call
      message = conversation.messages.new(params)
      result = message.save
      if result
        send_message(message)
        create_notification(message)
      end

      result
    end

    def send_message(message)
      SendMessageMailer.new_message(message).deliver_now
    end

    def create_notification(message)
      recipient_id = if owner == conversation.recipient
                       conversation.sender_id
                     else
                       conversation.recipient_id
                     end
      Notification.create!(message: message, recipient_id: recipient_id, read: false)
    end
  end
end
