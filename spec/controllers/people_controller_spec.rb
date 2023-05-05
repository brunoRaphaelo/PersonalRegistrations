# frozen_string_literal: true

require 'rails_helper'

describe PeopleController, type: :controller do
  describe '#index' do
    it 'must call people index' do
      get :index

      expect(response).to have_http_status :ok
    end

    it 'must call people index with sort options' do
      get :index, params: { sort_property: 'id', sort_direction: 'desc' }

      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    context 'when create have success' do
      it 'must return created status' do
        get :create, params: { person: attributes_for(:person) }

        expect(response).to have_http_status :created
      end

      it 'must have created one new person' do
        get :create, params: { person: attributes_for(:person) }

        expect(::Person.all).to_not be_empty
      end
    end

    context 'when create do not have success' do
      it 'must return unprocessable_entity status' do
        get :create, params: { person: { name: nil } }

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'must not have created any new person' do
        get :create, params: { person: { name: nil } }

        expect(::Person.all).to be_empty
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
    let(:person) { create(:person) }

    it 'must call people show' do
      get :show, params: { id: person.id }

      expect(response).to have_http_status :ok
    end

    it 'must return exactly object' do
      get :show, params: { id: person.id }

      expect(response.parsed_body['person']['id']).to eq ::Person.find(person.id).id
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
    let(:person) { create(:person) }

    context 'when update have success' do
      it 'must return ok status' do
        put :update, params: { id: person.id, person: attributes_for(:person) }

        expect(response).to have_http_status :ok
      end
    end

    context 'when update do not have success' do
      it 'must return unprocessable_entity status' do
        get :update, params: { id: person.id, person: { name: nil } }

        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when no parameters are sent' do
      it 'must call create and raise parameter missing' do
        assert_raises ActionController::ParameterMissing do
          put :update, params: { id: person.id }
        end
      end
    end

    context 'when searched id does not can not be founded' do
      it 'must return 404' do
        assert_raises ActiveRecord::RecordNotFound do
          get :update, params: { id: 0, person: attributes_for(:person) }
        end
      end
    end
  end

  describe '#destroy' do
    let(:person) { create(:person) }

    it 'must call people destroy' do
      delete :destroy, params: { id: person.id }

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
