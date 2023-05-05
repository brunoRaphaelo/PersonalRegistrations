# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/addresses')
        .to route_to(format: :json, controller: 'addresses', action: 'index')
    end

    it 'routes to #create' do
      expect(post: '/addresses')
        .to route_to(format: :json, controller: 'addresses', action: 'create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/addresses/1')
        .to route_to(format: :json, controller: 'addresses', action: 'update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/addresses/1')
        .to route_to(format: :json, controller: 'addresses', action: 'update', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/addresses/1')
        .to route_to(format: :json, controller: 'addresses', action: 'show', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/addresses/1')
        .to route_to(format: :json, controller: 'addresses', action: 'destroy', id: '1')
    end
  end
end
