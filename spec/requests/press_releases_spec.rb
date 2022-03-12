# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/press_releases', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /index' do
    let!(:press_releases) { create_list :press_release, 5 }

    it 'renders a successful response' do
      get press_releases_url, as: :json
      expect(response).to be_successful
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:press_release) { create :press_release }

    it 'renders a successful response' do
      get "/press_releases/#{press_release.slug}", as: :json
      expect(response).to be_successful
      expect(json['id']).to eq press_release.id
    end
  end
end
