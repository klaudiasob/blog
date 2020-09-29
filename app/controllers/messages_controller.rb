# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :authenticate_owner!

  def index
    @messages = @conversation.messages
    Message.with_unread_notifications(@conversation.id, current_owner.id).each do |message|
      message.notifications.each do |notification|
        notification.update(read: true) if notification.read == false
      end
    end

    if params[:show_all].nil? && @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    MessageServices::Create.new(message_params, @conversation, current_owner).call
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body, :sender_id)
  end
end
