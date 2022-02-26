require 'rails_helper'

RSpec.describe 'Writers', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /show' do
    let!(:writer) { create :writer }

    it 'renders a successful response' do
      get "/writers/#{writer.slug}", as: :json
      expect(response).to be_successful
      expect(json['id']).to eq writer.id
    end
  end
end
