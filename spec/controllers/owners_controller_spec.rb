# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OwnersController, type: :controller do
  describe 'GET #show' do
    let(:owner) { create(:owner) }

    it 'assigns the requested owner to @owner' do
      get :show, params: { id: owner.id }
      expect(assigns(:owner)).to eq(owner)
    end

    context 'when owner is logged in' do
      login_owner
      context 'when owner is current_owner' do
        it 'renders show template ' do
          get :show, params: { id: subject.current_owner.id }
          expect(response).to render_template('show')
        end
      end

      context 'when owner is not current_owner' do
        login_owner
        it 'redirects to root path ' do
          get :show, params: { id: owner.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when owner is not logged in' do
      it 'redirects to root path ' do
        get :show, params: { id: owner.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

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
        expect(response).to redirect_to(owner_path(subject.current_owner))
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
