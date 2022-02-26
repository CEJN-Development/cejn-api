require 'rails_helper'

RSpec.describe WritersController, type: :routing do
  describe 'routing' do
    let(:slug) { 'writer_slug' }

    it 'routes to #show' do
      expect(get: "/writers/#{slug}").to route_to('writers#show', slug: slug)
    end
  end
end
