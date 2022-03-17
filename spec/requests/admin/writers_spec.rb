# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/writers', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:valid_params) do
    {
      full_name: Faker::Name.name,
      byline: Faker::Lorem.paragraph(sentence_count: 4)
    }
  end

  describe 'GET /index' do
    let!(:writers) { create_list :writer, 5 }

    it 'renders a successful response' do
      get admin_writers_url, as: :json
      expect(response).to be_successful
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:writer) { create :writer }

    it 'renders a successful response' do
      get admin_writer_url(writer), as: :json
      expect(response).to be_successful
      expect(json['id']).to eq writer.id
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:params) { { writer: valid_params } }

      context 'when authenticated' do
        let!(:headers) { sign_user_in }

        it 'creates a new writer' do
          expect do
            post admin_writers_url, params: params, headers: headers, as: :json
          end.to change(Writer, :count).by 1
        end

        it 'renders a JSON response with the new writer' do
          post admin_writers_url, params: params, headers: headers, as: :json
          expect(response).to have_http_status :created
          expect(response.content_type).to match a_string_including('application/json')
          expect(json['full_name']).to eq valid_params[:full_name]
          expect(json['byline']).to eq valid_params[:byline]
          expect(json['slug']).to eq valid_params[:full_name].parameterize
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { writer: valid_params.merge({ byline: nil }) } }

          it 'does not create a new writer' do
            expect do
              post admin_writers_url, params: invalid_params, headers: headers, as: :json
            end.to change(Writer, :count).by(0)
          end

          it 'renders a JSON response with errors for the new writer' do
            post admin_writers_url, params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          post admin_writers_url, params: params, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'PATCH /update' do
    let!(:writer) { create :writer }

    context 'with valid parameters' do
      let(:new_attributes) do
        {
          full_name: Faker::Name.name,
          byline: Faker::Lorem.paragraph(sentence_count: 3)
        }
      end
      let(:params) { { writer: new_attributes } }

      context 'when authenticated' do
        let!(:headers) { sign_user_in }

        it 'updates the requested writer' do
          patch admin_writer_url(writer), params: params, headers: headers, as: :json
          writer.reload
          expect(writer.full_name).to eq new_attributes[:full_name]
          expect(writer.byline).to eq new_attributes[:byline]
        end

        it 'renders a JSON response with the updated writer' do
          patch admin_writer_url(writer), params: params, headers: headers, as: :json
          expect(response).to have_http_status :ok
          expect(response.content_type).to match a_string_including('application/json')
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { writer: valid_params.merge({ byline: nil }) } }

          it 'does not create a new writer' do
            expect do
              patch admin_writer_url(writer), params: invalid_params, headers: headers, as: :json
            end.to change(Writer, :count).by(0)
          end

          it 'renders a JSON response with errors for the new writer' do
            patch admin_writer_url(writer), params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          patch admin_writer_url(writer), params: params, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:writer) { create :writer }

    context 'with authentication' do
      let!(:headers) { sign_user_in }

      it 'destroys the requested writer' do
        expect do
          delete admin_writer_url(writer), headers: headers, as: :json
        end.to change(Writer, :count).by(-1)
      end
    end

    it 'returns unauthorized response' do
      expect do
        delete admin_writer_url(writer), headers: headers, as: :json
      end.to change(Writer, :count).by(0)
      expect(response).to be_unauthorized
    end
  end
end
