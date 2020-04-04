# frozen_string_literal: true

class SendMessageMailer < ApplicationMailer
  def new_message(message)
    @conversation = message.conversation
    @owner = if message.sender_id == @conversation.recipient_id
               @conversation.sender
             else
               @conversation.recipient
             end
    mail(to: @owner.email, subject: 'Hey! Here is what you missed')
  end
end
