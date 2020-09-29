# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OwnersController, type: :controller do
    describe 'PATCH #update' do
    login_owner

    context 'when params include owner attributes' do
      let(:params) do
        {
          id: subject.current_owner.id,
          owner: {
            'first_name' => 'Test',
            'last_name' => 'TestTest'
          }
        }
      end

      it 'updates owner attributes' do
        patch :update, params: params
        expect(subject.current_owner.reload.attributes).to match(hash_including(params[:owner]))
      end

      it 'redirects to owner path' do
        patch :update, params: params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          id: subject.current_owner.id,
          owner: {
            'first_name' => nil
          }
        }
      end

      it 'renders edit template' do
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
end
