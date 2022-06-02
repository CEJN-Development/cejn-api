# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/events', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get events_url, as: :json
      expect(response).to be_successful
    end

    context 'with events' do
      let!(:events) { create_list :event, 5 }

      it 'renders the events' do
        get events_url, as: :json
        expect(json).to match_array JSON.parse(events.to_json)
      end
    end
  end

  describe 'GET /show' do
    let!(:event) { create :event }

    it 'renders a successful response' do
      get event_url(event), as: :json
      expect(response).to be_successful
      expect(json['id']).to eq event.id
    end
  end

  describe 'GET /next' do
    let!(:expired_event) { create :event, date: Faker::Date.backward(days: 10) }
    let!(:later_upcoming_event) { create :event }
    let!(:nearer_upcoming_event) { create :event, date: Faker::Date.forward(days: 1) }

    it 'renders nearest upcoming event' do
      get next_events_url, as: :json
      expect(json['id']).to eq nearer_upcoming_event.id
    end
  end
end
