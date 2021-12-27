# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/articles', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /index' do
    let!(:articles) { create_list :article, 5 }

    it 'renders a successful response' do
      get articles_url, as: :json
      expect(response).to be_successful
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:article) { create :article }

    it 'renders a successful response' do
      get "/articles/#{article.slug}", as: :json
      expect(response).to be_successful
      expect(json['id']).to eq article.id
    end
  end
end
