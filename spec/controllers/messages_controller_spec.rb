require 'rails_helper'
RSpec.describe MessagesController, type: :controller do

  describe 'GET #index' do
    login_owner
    let(:conversation) { create(:conversation) }


    context 'conversation has less then 10 messages' do
      it 'assigns @messages' do
        messages = create_list(:message, 3, sender_id: subject.current_owner.id, conversation_id: conversation.id)
        get :index, params: { conversation_id: conversation.id }
        expect(assigns(:messages).count).to eq(messages.count)
      end
    end

    context 'conversation has more then 10 messages' do
      it 'assigns @messages' do
        create_list(:message, 11, sender_id: subject.current_owner.id, conversation_id: conversation.id)
        get :index, params: { conversation_id: conversation.id }
        expect(assigns(:messages).count).to eq(10)
      end

      context 'param show_all is present' do
        it 'assigns @messages' do
          messages = create_list(:message, 11, sender_id: subject.current_owner.id, conversation_id: conversation.id)
          get :index, params: { conversation_id: conversation.id, show_all: 'true' }
          expect(assigns(:messages).count).to eq(messages.count)
        end
      end
    end

    context 'message has unread notification' do
      let(:message) { create(:message, conversation_id: conversation.id) }
      let!(:notification) { create(:notification, :not_readed, message_id: message.id, recipient_id: subject.current_owner.id) }
      it 'updates notification' do
        get :index, params: { conversation_id: conversation.id }
        expect(notification.reload.read?). to eq(true)
      end
    end

    it 'renders index template' do
      get :index, params: { conversation_id: conversation.id }
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    login_owner
    let(:conversation) { create(:conversation) }
    let(:message) { create(:message, sender_id: subject.current_owner.id, conversation_id: conversation.id) }
    let(:message_params) { attributes_for(:message, sender_id: subject.current_owner.id.to_s, conversation_id: conversation.id) }


    it 'calls MessageServices::Create' do
      params = ActionController::Parameters.new(message_params).permit(:body, :sender_id)

      expect(MessageServices::Create).to receive(:new).with(params, conversation, subject.current_owner).and_call_original
      expect_any_instance_of(MessageServices::Create).to receive(:call)

      post :create, params: { conversation_id: conversation.id, message: message_params }
    end

    it 'redirects to conversation_messages path' do
      allow_any_instance_of(MessageServices::Create).to receive(:call).and_return(true)

      post :create, params: { conversation_id: conversation.id, message: message_params }
      expect(response).to redirect_to conversation_messages_path(conversation)
    end
  end
end