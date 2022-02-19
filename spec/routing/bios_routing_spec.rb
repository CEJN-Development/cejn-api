require 'rails_helper'

RSpec.describe OrganizationsController, type: :routing do
  describe 'routing' do
    let(:slug) { 'organization_slug' }

    it 'routes to #index' do
      expect(get: '/organizations').to route_to('organizations#index')
    end

    it 'routes to #show' do
      expect(get: "/organizations/#{slug}").to route_to('organizations#show', slug: slug)
    end
  end
end
