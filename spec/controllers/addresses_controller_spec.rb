require 'rails_helper'

describe AddressesController, type: :controller do
  describe '#index' do
    it 'must call address index' do
      get :index

      expect(response).to have_http_status :ok
    end

    it 'must call address index with sort options' do
      get :index, params: { sort_property: 'id', sort_direction: 'desc'  }

      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    context 'when create have success' do
      it 'must return created status' do
        get :create, params: { address: attributes_for(:address) }

        expect(response).to have_http_status :created
      end

      it 'must have created one new address' do
        get :create, params: { address: attributes_for(:address) }

        expect(::Address.all).to_not be_empty
      end
    end

    context 'when create do not have success' do
      it 'must return unprocessable_entity status' do
        get :create, params: { address: { postal_code: nil} }

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'must not have created any new address' do
        get :create, params: { address: { postal_code: nil} }

        expect(::Address.all).to be_empty
      end
    end

    context 'when no parameters are sent' do
      it 'must call create and raise parameter missing' do
        assert_raises ActionController::ParameterMissing do
          post :create, params: {}
        end
      end
    end
  end

  describe '#show' do
    let(:address) { create(:address) }

    it 'must call address show' do
      get :show, params: { id: address.id}

      expect(response).to have_http_status :ok
    end

    it 'must return exactly object' do
      get :show, params: { id: address.id}

      expect(response.parsed_body['address']['id']).to eq ::Address.find(address.id).id
    end

    context 'when searched id does not can not be founded' do
      it 'must return 404' do
        assert_raises ActiveRecord::RecordNotFound do
          get :show, params: { id: 0 }
        end
      end
    end
  end

  describe '#update' do
    let(:address) { create(:address) }

    context 'when update have success' do
      it 'must return ok status' do
        put :update, params: { id: address.id, address: attributes_for(:address) }

        expect(response).to have_http_status :ok
      end
    end

    context 'when update do not have success' do
      it 'must return unprocessable_entity status' do
        get :update, params: { id: address.id, address: { postal_code: nil} }

        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when no parameters are sent' do
      it 'must call create and raise parameter missing' do
        assert_raises ActionController::ParameterMissing do
          put :update, params: { id: address.id }
        end
      end
    end

    context 'when searched id does not can not be founded' do
      it 'must return 404' do
        assert_raises ActiveRecord::RecordNotFound do
          get :update, params: { id: 0, address: attributes_for(:address) }
        end
      end
    end
  end

  describe '#destroy' do
    let(:address) { create(:address) }

    it 'must call address destroy' do
      delete :destroy, params: { id: address.id }

      expect(response).to have_http_status :ok
    end

    context 'when searched id does not can not be founded' do
      it 'must return 404' do
        assert_raises ActiveRecord::RecordNotFound do
          delete :destroy, params: { id: 0 }
        end
      end
    end
  end
end
