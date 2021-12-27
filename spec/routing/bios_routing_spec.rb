require 'rails_helper'

RSpec.describe BiosController, type: :routing do
  describe 'routing' do
    let(:slug) { 'bio_slug' }

    it 'routes to #index' do
      expect(get: '/bios').to route_to('bios#index')
    end

    it 'routes to #show' do
      expect(get: "/bios/#{slug}").to route_to('bios#show', slug: slug)
    end
  end
end
