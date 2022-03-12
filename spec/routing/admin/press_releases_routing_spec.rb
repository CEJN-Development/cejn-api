# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::PressReleasesController, type: :routing do
  describe 'routing' do
    let(:id) { '1' }

    it 'routes to #index' do
      expect(get: '/admin/press_releases').to route_to('admin/press_releases#index')
    end

    it 'routes to #show' do
      expect(get: "/admin/press_releases/#{id}").to route_to('admin/press_releases#show', id: id)
    end

    it 'routes to #create' do
      expect(post: '/admin/press_releases').to route_to('admin/press_releases#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "/admin/press_releases/#{id}").to route_to('admin/press_releases#update', id: id)
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/admin/press_releases/#{id}").to route_to('admin/press_releases#update', id: id)
    end

    it 'routes to #destroy' do
      expect(delete: "/admin/press_releases/#{id}").to route_to('admin/press_releases#destroy', id: id)
    end
  end
end
