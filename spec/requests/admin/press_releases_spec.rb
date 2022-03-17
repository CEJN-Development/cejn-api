# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/press_releases', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:valid_params) do
    {
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph(sentence_count: 4, random_sentences_to_add: 4),
      summary: Faker::Lorem.paragraph(sentence_count: 4)
    }
  end

  describe 'GET /index' do
    let!(:press_releases) { create_list :press_release, 5 }

    it 'renders a successful response' do
      get admin_press_releases_url, as: :json
      expect(response).to be_successful
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:press_release) { create :press_release }

    it 'renders a successful response' do
      get admin_press_release_url(press_release), as: :json
      expect(response).to be_successful
      expect(json['id']).to eq press_release.id
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:params) { { press_release: valid_params } }

      context 'when authenticated' do
        let!(:headers) { sign_user_in }

        it 'creates a new press release' do
          expect do
            post admin_press_releases_url, params: params, headers: headers, as: :json
          end.to change(PressRelease, :count).by 1
        end

        it 'renders a JSON response with the new press release' do
          post admin_press_releases_url, params: params, headers: headers, as: :json
          expect(response).to have_http_status :created
          expect(response.content_type).to match a_string_including('application/json')
          expect(json['title']).to eq valid_params[:title]
          expect(json['body']).to eq valid_params[:body]
          expect(json['summary']).to eq valid_params[:summary]
          expect(json['slug']).to eq valid_params[:title].parameterize
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { press_release: valid_params.merge({ body: nil }) } }

          it 'does not create a new press release' do
            expect do
              post admin_press_releases_url, params: invalid_params, headers: headers, as: :json
            end.to change(PressRelease, :count).by(0)
          end

          it 'renders a JSON response with errors for the new press_release' do
            post admin_press_releases_url, params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          post admin_press_releases_url, params: params, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'PATCH /update' do
    let!(:press_release) { create :press_release }

    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: "The Life of #{Faker::Name.name}",
          body: Faker::Lorem.paragraph(sentence_count: 3, random_sentences_to_add: 5),
          summary: Faker::Lorem.paragraph(sentence_count: 5)
        }
      end
      let(:params) { { press_release: new_attributes } }

      context 'with authentication' do
        let!(:headers) { sign_user_in }

        it 'updates the requested press release' do
          patch admin_press_release_url(press_release), params: params, headers: headers, as: :json
          press_release.reload
          expect(press_release.title).to eq new_attributes[:title]
          expect(press_release.body).to eq new_attributes[:body]
          expect(press_release.summary).to eq new_attributes[:summary]
        end

        it 'renders a JSON response with the press release' do
          patch admin_press_release_url(press_release), params: params, headers: headers, as: :json
          expect(response).to be_ok
          expect(response.content_type).to match a_string_including('application/json')
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { press_release: valid_params.merge({ title: nil }) } }

          it 'renders a JSON response with errors for the press release' do
            patch admin_press_release_url(press_release), params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          patch admin_press_release_url(press_release), params: params, headers: headers, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:press_release) { create :press_release }

    context 'with authentication' do
      let!(:headers) { sign_user_in }

      it 'destroys the requested press release' do
        expect do
          delete admin_press_release_url(press_release), headers: headers, as: :json
        end.to change(PressRelease, :count).by(-1)
      end
    end

    it 'returns unauthorized response' do
      expect do
        delete admin_press_release_url(press_release), headers: headers, as: :json
      end.to change(PressRelease, :count).by(0)
      expect(response).to be_unauthorized
    end
  end
end
