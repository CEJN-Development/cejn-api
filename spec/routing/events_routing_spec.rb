require 'rails_helper'

RSpec.describe EventsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/events').to route_to('events#index')
    end

    it 'routes to #show' do
      expect(get: '/events/slug').to route_to('events#show', slug: 'slug')
    end

    it 'routes to #next' do
      expect(get: '/events/next').to route_to('events#next')
    end
  end
end
