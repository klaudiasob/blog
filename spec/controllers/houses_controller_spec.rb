# frozen_string_literal: true

require 'rails_helper'
RSpec.describe HousesController, type: :controller do
  describe 'GET #index_owner' do
    context 'when owner is logged' do
      login_owner
      it 'assigns @houses' do
        create_list(:house, 3)
        houses = create_list(:house, 3, owner: subject.current_owner)
        get :index_owner
        expect(assigns(:houses).to_a).to eq(houses)
      end
    end
  end

  describe 'GET #index' do
    it 'assigns @houses' do
      houses = create_list(:house, 5)
      get :index
      expect(assigns(:houses)).to eq(houses)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested house to @house' do
      house = create(:house)
      get :show, params: { id: house.id }
      expect(assigns(:house)).to eq(house)
    end

    context 'when house is not deleted' do
      it 'renders the show template' do
        house = create(:house, :not_deleted)
        get :show, params: { id: house.id }
        expect(response).to render_template('show')
      end
    end

    context 'when house is deleted' do
      context 'when house owner is current owner' do
        login_owner
        it 'renders the show template' do
          house = create(:house, :deleted, owner: subject.current_owner)
          get :show, params: { id: house.id }
          expect(response).to render_template('show')
        end
      end

      context 'when current owner is not house owner' do
        login_owner
        it 'redirects to the home page' do
          house = create(:house, :deleted)
          get :show, params: { id: house.id }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when current owner is not present' do
        it 'redirects to the home page' do
          house = create(:house, :deleted)
          get :show, params: { id: house.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when current_owner present' do
      login_owner
      context 'with valid attributes' do
        it 'creates a new house' do
          expect do
            post :create, params: { house: attributes_for(:house) }
          end.to change(House, :count).by(1)
        end

        it 'redirects to the new house' do
          post :create, params: { house: attributes_for(:house) }
          expect(response).to redirect_to House.last
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new house' do
          expect do
            post :create, params: { house: attributes_for(:house, :not_valid) }
          end.not_to change(House, :count)
        end

        it 're-renders the new method' do
          post :create, params: { house: attributes_for(:house, :not_valid) }
          expect(response).to render_template :new
        end
      end
    end

    context 'when current_owner is not present' do
      it 'redirects to the root path' do
        post :create
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH #update' do
    login_owner

    let(:house) { create(:house, owner: subject.current_owner) }
    let(:params) do
      {
        id: house.id,
        house: { description: '' }
      }
    end

    it 'calls HouseServices::Update' do
      house_params = ActionController::Parameters.new(params[:house]).permit(:description)

      expect(HouseServices::Update).to receive(:new).with(house, house_params).and_call_original
      expect_any_instance_of(HouseServices::Update).to receive(:call)

      patch :update, params: params
    end

    context 'when house has been updated' do
      it 'redirects to house path' do
        allow_any_instance_of(HouseServices::Update).to receive(:call).and_return(true)

        patch :update, params: params
        expect(response).to redirect_to house
      end
    end

    context 'when house update failed' do
      it 'renders the edit template' do
        allow_any_instance_of(HouseServices::Update).to receive(:call).and_return(false)

        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    login_owner
    let!(:house) { create(:house, owner: subject.current_owner) }

    it 'deletes the house' do
      expect do
        delete :destroy, params: { id: house.id }
      end.to change(House.without_deleted, :count).by(-1)
    end

    it 'redirects to houses#index' do
      delete :destroy, params: { id: house.id }
      expect(response).to redirect_to root_path
    end
  end
end
