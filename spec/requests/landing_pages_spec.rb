require 'rails_helper'

RSpec.describe 'LandingPages', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /show' do
    let!(:landing_page) { create :landing_page }

    it 'renders a successful response' do
      get "/landing_pages/#{landing_page.slug}", as: :json
      expect(response).to be_successful
      expect(json['slug']).to eq landing_page.slug
    end
  end
end
