class SendMessageMailer < ApplicationMailer
  def new_message(message)
    @conversation = message.conversation
    if message.sender_id == @conversation.recipient_id
      @owner = @conversation.sender
    else
      @owner = @conversation.recipient
    end
    mail(to: @owner.email, subject: 'Hey! Here is what you missed')
  end
end
