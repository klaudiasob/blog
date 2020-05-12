require 'rails_helper'

RSpec.describe MessageServices::Create do
  subject(:create_message) { described_class.new(message_params, conversation, owner).call }

  let(:conversation) { create(:conversation) }
  let(:owner) { create(:owner) }
  let(:message_params) { attributes_for(:message).merge({ sender_id: conversation.sender.id }) }


  describe '.call' do
    before(:each) do
      allow(SendMessageMailer).to receive(:new_message).and_call_original
    end

    it 'creates message' do
      expect { create_message }.to change(Message, :count).by(1)
    end

    it 'assigns proper attributes to message' do
      create_message
      expect(Message.last.sender).to eq(conversation.sender)
      expect(Message.last.body).to eq(message_params[:body])
    end

    it 'creates notification' do
      expect { create_message }.to change(Notification, :count).by(1)
    end

    it 'sends an email' do
      expect(SendMessageMailer).to receive(:new_message)
      create_message
    end


    context 'owner is conversation recipient' do
      let(:owner) { conversation.recipient }
      it 'assigns proper recipient to notification' do
        create_message
        expect(Notification.last.recipient_id).to eq(conversation.sender_id)
      end
    end

    context 'owner is not conversation recipient' do
      let(:owner) { conversation.sender }
      it 'assigns proper recipient to notification' do
        create_message
        expect(Notification.last.recipient_id).to eq(conversation.recipient_id)
      end
    end
  end


end

