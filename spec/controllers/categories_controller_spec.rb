# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    login_owner
    let(:category) { create_list(:category, 3) }

    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to eq(category)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested category to @category' do
      category = create(:category)
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category) }

    context 'when current owner is an admin' do
      login_admin
      let(:params) do
        {
          id: category.id,
          category: {
            'name' => 'Test'
          }
        }
      end

      it 'updates category attributes' do
        patch :update, params: params
        expect(category.reload.attributes).to match(hash_including(params[:category]))
      end
    end

    context 'when current owner is not an admin' do
      let(:params) do
        {
          id: category.id,
          category: {
            'name' => 'Test'
          }
        }
      end

      it 'redirects to root path' do
        patch :update, params: params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when current_owner is an admin' do
      login_admin
      context 'with valid attributes' do
        it 'creates a new category' do
          expect do
            post :create, params: { category: attributes_for(:category) }
          end.to change(Category, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not save category' do
          expect do
            post :create, params: { category: attributes_for(:category, :invalid) }
          end.not_to change(Category, :count)
        end
      end
    end

    context 'when current_owner is not an admin' do
      login_owner
      it 'redirects to root path' do
        post :create
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category) }

    context 'when current_owner is an admin' do
      login_admin
      it 'deletes the category' do
        expect do
          delete :destroy, params: { id: category.id }
        end.to change(Category, :count).by(-1)
      end
    end

    context 'when current_owner is not an admin' do
      login_owner
      it 'does not delete category' do
        expect do
          delete :destroy, params: { id: category.id }
        end.not_to change(Category, :count)
      end
    end
  end
end
