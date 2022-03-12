# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  describe 'routing' do
    let(:slug) { 'press_release_slug' }

    it 'routes to #index' do
      expect(get: '/press_releases').to route_to('press_releases#index')
    end

    it 'routes to #show' do
      expect(get: "/press_releases/#{slug}").to route_to('press_releases#show', slug: slug)
    end
  end
end
