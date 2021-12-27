require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :routing do
  describe 'routing' do
    let(:id) { '1' }

    it 'routes to #index' do
      expect(get: '/admin/articles').to route_to('admin/articles#index')
    end

    it 'routes to #show' do
      expect(get: "/admin/articles/#{id}").to route_to('admin/articles#show', id: id)
    end

    it 'routes to #create' do
      expect(post: '/admin/articles').to route_to('admin/articles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "/admin/articles/#{id}").to route_to('admin/articles#update', id: id)
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/admin/articles/#{id}").to route_to('admin/articles#update', id: id)
    end

    it 'routes to #destroy' do
      expect(delete: "/admin/articles/#{id}").to route_to('admin/articles#destroy', id: id)
    end
  end
end
