# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/organizations', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:valid_params) do
    {
      name: Faker::Name.name,
      body: Faker::Lorem.paragraph(sentence_count: 4),
      blurb: Faker::Lorem.paragraph(sentence_count: 4)
    }
  end

  describe 'GET /index' do
    let!(:organizations) { create_list :organization, 5 }

    it 'renders a successful response' do
      get admin_organizations_url, as: :json
      expect(response).to be_successful
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:organization) { create :organization }

    it 'renders a successful response' do
      get admin_organization_url(organization), as: :json
      expect(response).to be_successful
      expect(json['id']).to eq organization.id
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:params) { { organization: valid_params } }

      context 'when authenticated' do
        let!(:headers) { sign_user_in }

        it 'creates a new organization' do
          expect do
            post admin_organizations_url, params: params, headers: headers, as: :json
          end.to change(Organization, :count).by 1
        end

        it 'renders a JSON response with the new organization' do
          post admin_organizations_url, params: params, headers: headers, as: :json
          expect(response).to have_http_status :created
          expect(response.content_type).to match a_string_including('application/json')
          expect(json['name']).to eq valid_params[:name]
          expect(json['body']).to eq valid_params[:body]
          expect(json['slug']).to eq valid_params[:name].parameterize
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { organization: valid_params.merge({ body: nil }) } }

          it 'does not create a new organization' do
            expect do
              post admin_organizations_url, params: invalid_params, headers: headers, as: :json
            end.to change(Organization, :count).by(0)
          end

          it 'renders a JSON response with errors for the new organization' do
            post admin_organizations_url, params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          post admin_organizations_url, params: params, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'PATCH /update' do
    let!(:organization) { create :organization }

    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: Faker::Name.name,
          body: Faker::Lorem.paragraph(sentence_count: 3),
          blurb: Faker::Lorem.paragraph(sentence_count: 3)
        }
      end
      let(:params) { { organization: new_attributes } }

      context 'when authenticated' do
        let!(:headers) { sign_user_in }

        it 'updates the requested organization' do
          patch admin_organization_url(organization), params: params, headers: headers, as: :json
          organization.reload
          expect(organization.name).to eq new_attributes[:name]
          expect(organization.blurb).to eq new_attributes[:blurb]
          expect(organization.body).to eq new_attributes[:body]
        end

        it 'renders a JSON response with the updated organization' do
          patch admin_organization_url(organization), params: params, headers: headers, as: :json
          expect(response).to have_http_status :ok
          expect(response.content_type).to match a_string_including('application/json')
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { { organization: valid_params.merge({ body: nil }) } }

          it 'does not create a new organization' do
            expect do
              patch admin_organization_url(organization), params: invalid_params, headers: headers, as: :json
            end.to change(Organization, :count).by(0)
          end

          it 'renders a JSON response with errors for the new organization' do
            patch admin_organization_url(organization), params: invalid_params, headers: headers, as: :json
            expect(response).to have_http_status :unprocessable_entity
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          patch admin_organization_url(organization), params: params, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:organization) { create :organization }

    context 'with authentication' do
      let!(:headers) { sign_user_in }

      it 'destroys the requested organization' do
        expect do
          delete admin_organization_url(organization), headers: headers, as: :json
        end.to change(Organization, :count).by(-1)
      end
    end

    it 'returns unauthorized response' do
      expect do
        delete admin_organization_url(organization), headers: headers, as: :json
      end.to change(Organization, :count).by(0)
      expect(response).to be_unauthorized
    end
  end
end
