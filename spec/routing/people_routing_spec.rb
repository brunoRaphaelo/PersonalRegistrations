require 'rails_helper'

RSpec.describe PeopleController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/people')
        .to route_to(format: :json, controller: 'people', action: 'index')
    end

    it 'routes to #create' do
      expect(post: '/people')
        .to route_to(format: :json, controller: 'people', action: 'create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/people/1')
        .to route_to(format: :json, controller: 'people', action: 'update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/people/1')
        .to route_to(format: :json, controller: 'people', action: 'update', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/people/1')
        .to route_to(format: :json, controller: 'people', action: 'show', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/people/1')
        .to route_to(format: :json, controller: 'people', action: 'destroy', id: '1')
    end
  end
end
