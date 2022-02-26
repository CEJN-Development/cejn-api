require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  describe 'routing' do
    let(:slug) { 'article_slug' }

    it 'routes to #index' do
      expect(get: '/articles').to route_to('articles#index')
    end

    it 'routes to #show' do
      expect(get: "/articles/#{slug}").to route_to('articles#show', slug: slug)
    end
  end
end
