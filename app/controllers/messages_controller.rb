class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    @conversation.unread_notifications(current_owner.id).each do |message|
      message.notifications.each do |notification|
        notification.update!(read: true) if notification.read == false
      end
    end

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      SendMessageMailer.new_message(@message).deliver_now

      if current_owner == @conversation.recipient
        recipient_id = @conversation.sender_id
      else
        recipient_id = @conversation.recipient_id
      end
      Notification.create!(message: @message, recipient_id: recipient_id, read: false)
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :sender_id)
  end

end