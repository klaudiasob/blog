require "rails_helper"


RSpec.describe SendMessageMailer, :type => :mailer do
  describe 'new message' do
    let(:mail) { SendMessageMailer.new_message(message) }
    let(:message_sender) { create(:owner, email: 'from@example.com') }


    context 'message sender is conversation recipient' do
      let(:conversation_sender) { create(:owner, email: 'to@example.com') }
      let(:conversation) { create(:conversation, sender_id: conversation_sender.id, recipient_id: message_sender.id) }
      let(:message) { create(:message, conversation_id: conversation.id, sender_id: message_sender.id) }

      it "renders the headers" do
        expect(mail.subject).to eq('Hey! Here is what you missed')
        expect(mail.to).to eq(["to@example.com"])
        expect(mail.from).to eq(["from@example.com"])
      end
    end

    context 'message sender is not conversation recipient' do
      let(:conversation_recipient) { create(:owner, email: 'to@example.com') }
      let(:conversation) { create(:conversation, sender_id: message_sender.id, recipient_id: conversation_recipient.id) }
      let(:message) { create(:message, conversation_id: conversation.id, sender_id: message_sender.id) }

      it "renders the headers" do
        expect(mail.subject).to eq('Hey! Here is what you missed')
        expect(mail.to).to eq(["to@example.com"])
        expect(mail.from).to eq(["from@example.com"])
      end
    end
  end
end
