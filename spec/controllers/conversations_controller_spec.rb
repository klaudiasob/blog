# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ConversationsController, type: :controller do
  describe 'GET #index' do
    let(:conversation) { create_list(:conversation, 3) }

    login_owner
    it 'assigns @conversation' do
      get :index
      expect(assigns(:conversations)).to eq(conversation)
    end
  end

  describe 'POST #create' do
    let(:recipient) { create(:owner) }
    let(:sender) { create(:owner) }

    login_owner
    context 'when conversation present' do
      let!(:conversation) { create(:conversation, sender_id: subject.current_owner.id, recipient_id: recipient.id) }

      it 'does not create new conversation' do
        expect do
          post :create, params: { sender_id: subject.current_owner.id, recipient_id: recipient.id }
        end.not_to change(Conversation, :count)
      end

      it 'redirects to the conversation path' do
        post :create, params: { sender_id: subject.current_owner.id, recipient_id: recipient.id }
        expect(response).to redirect_to(conversation_messages_path(conversation) )
      end
    end

    context 'when conversation not present' do
      it 'creates new conversation' do
        expect do
          post :create, params: { sender_id: subject.current_owner.id, recipient_id: recipient.id }
        end.to change(Conversation, :count).by(1)
      end
    end


  end
end
