# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/events', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:valid_params) do
    {
      name: Faker::Book.name,
      body: Faker::Lorem.paragraph(sentence_count: 4, random_sentences_to_add: 4),
      description: Faker::Lorem.paragraph(sentence_count: 4),
      date: Faker::Time.forward(days: 5)
    }
  end

  describe 'GET /index' do
    let!(:events) { create_list :event, 5 }

    it 'renders a successful response' do
      get admin_events_url, as: :json
      expect(response).to be_successful
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:event) { create :event }

    it 'renders a successful response' do
      get admin_event_url(event), as: :json
      expect(response).to be_successful
      expect(json['id']).to eq event.id
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:params) { { event: valid_params } }

      context 'when authenticated' do
        let!(:headers) { sign_user_in }

        it 'creates a new event' do
          expect do
            post admin_events_url, params: params, headers: headers, as: :json
          end.to change(Event, :count).by 1
        end

        it 'renders a JSON response with the new event' do
          post admin_events_url, params: params, headers: headers, as: :json
          expect(response).to have_http_status :created
          expect(response.content_type).to match a_string_including('application/json')
          expect(json['name']).to eq valid_params[:name]
          expect(json['body']).to eq valid_params[:body]
          expect(json['description']).to eq valid_params[:description]
          expect(json['slug']).to eq valid_params[:name].parameterize
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { event: valid_params.merge({ body: nil }) } }

          it 'does not create a new event' do
            expect do
              post admin_events_url, params: invalid_params, headers: headers, as: :json
            end.to change(Event, :count).by(0)
          end

          it 'renders a JSON response with errors for the new event' do
            post admin_events_url, params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          post admin_events_url, params: params, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'PATCH /update' do
    let!(:event) { create :event }

    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: "The Life of #{Faker::Name.name}",
          body: Faker::Lorem.paragraph(sentence_count: 3, random_sentences_to_add: 5),
          description: Faker::Lorem.paragraph(sentence_count: 5),
          date: Faker::Time.forward(days: 1)
        }
      end
      let(:params) { { event: new_attributes } }

      context 'with authentication' do
        let!(:headers) { sign_user_in }

        it 'updates the requested event' do
          patch admin_event_url(event), params: params, headers: headers, as: :json
          event.reload
          expect(event.name).to eq new_attributes[:name]
          expect(event.body).to eq new_attributes[:body]
          expect(event.description).to eq new_attributes[:description]
        end

        it 'renders a JSON response with the event' do
          patch admin_event_url(event), params: params, headers: headers, as: :json
          expect(response).to be_ok
          expect(response.content_type).to match a_string_including('application/json')
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { event: valid_params.merge({ name: nil }) } }

          it 'renders a JSON response with errors for the event' do
            patch admin_event_url(event), params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          patch admin_event_url(event), params: params, headers: headers, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:event) { create :event }

    context 'with authentication' do
      let!(:headers) { sign_user_in }

      it 'destroys the requested event' do
        expect do
          delete admin_event_url(event), headers: headers, as: :json
        end.to change(Event, :count).by(-1)
      end
    end

    it 'returns unauthorized response' do
      expect do
        delete admin_event_url(event), headers: headers, as: :json
      end.to change(Event, :count).by(0)
      expect(response).to be_unauthorized
    end
  end
end
