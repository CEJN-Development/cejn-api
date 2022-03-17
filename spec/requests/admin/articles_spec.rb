# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/articles', type: :request do
  let(:headers) { {} }
  let(:json) { JSON.parse(response.body) }
  let(:valid_params) do
    {
      title: Faker::Book.title,
      body: Faker::Lorem.paragraph(sentence_count: 4, random_sentences_to_add: 4),
      excerpt: Faker::Lorem.paragraph(sentence_count: 4)
    }
  end

  describe 'GET /index' do
    let!(:articles) { create_list :article, 5 }

    it 'renders a successful response' do
      get admin_articles_url, as: :json
      expect(response).to be_ok
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:article) { create :article }

    it 'renders a successful response' do
      get admin_article_url(article), as: :json
      expect(response).to be_ok
      expect(json['id']).to eq article.id
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      context 'when authenticated' do
        let!(:headers) { sign_user_in }

        it 'requires an author to create a new Article' do
          expect do
            post admin_articles_url, params: { article: valid_params }, headers: headers, as: :json
          end.to change(Article, :count).by 0
          expect(json['message']).to eq 'An author is required.'
        end

        context 'with an author' do
          let!(:writer) { create :writer }
          let(:params) { { article: valid_params, author_ids: [writer.id] } }

          before do
            valid_params.merge!({ author_ids: [writer.id] })
          end

          it 'creates a new Article' do
            expect do
              post admin_articles_url, params: params, headers: headers, as: :json
            end.to change(Article, :count).by 1
          end

          it 'renders a JSON response with the new article' do
            post admin_articles_url, params: { article: valid_params }, headers: headers, as: :json
            expect(response).to have_http_status :created
            expect(response.content_type).to match a_string_including('application/json')
            expect(json['title']).to eq valid_params[:title]
            expect(json['body']).to eq valid_params[:body]
            expect(json['excerpt']).to eq valid_params[:excerpt]
            expect(json['slug']).to eq valid_params[:title].parameterize
          end

          context 'with invalid parameters' do
            let!(:invalid_params) { valid_params.merge({ body: nil }) }

            it 'does not create a new Article' do
              expect do
                post admin_articles_url, params: { article: invalid_params }, headers: headers, as: :json
              end.to change(Article, :count).by(0)
            end

            it 'renders a JSON response with errors for the new article' do
              post admin_articles_url, params: { article: invalid_params }, headers: headers, as: :json
              expect(response).to have_http_status(:unprocessable_entity)
              expect(response.content_type).to match a_string_including('application/json')
            end
          end
        end
      end

      context 'without authentication' do
        let!(:writer) { create :writer }
        let(:params) { { article: valid_params, author_ids: [writer.id] } }

        it 'returns authorization error' do
          post admin_articles_url, params: params, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'PATCH /update' do
    let!(:article) { create :article }

    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: "The Life of #{Faker::Name.name}",
          body: Faker::Lorem.paragraph(sentence_count: 3, random_sentences_to_add: 5),
          excerpt: Faker::Lorem.paragraph(sentence_count: 5)
        }
      end

      context 'with authentication' do
        let!(:headers) { sign_user_in }

        it 'updates the requested article' do
          patch admin_article_url(article), params: { article: new_attributes }, headers: headers, as: :json
          expect(article.reload.title).to eq new_attributes[:title]
          expect(article.reload.body).to eq new_attributes[:body]
          expect(article.reload.excerpt).to eq new_attributes[:excerpt]
        end

        it 'renders a JSON response with the article' do
          patch admin_article_url(article), params: { article: new_attributes }, headers: headers, as: :json
          expect(response).to be_ok
          expect(response.content_type).to match a_string_including('application/json')
        end

        context 'with invalid parameters' do
          let!(:invalid_params) { valid_params.merge({ title: nil }) }

          it 'renders a JSON response with errors for the article' do
            patch admin_article_url(article), params: { article: invalid_params }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match a_string_including('application/json')
          end
        end
      end

      context 'without authentication' do
        it 'returns authorization error' do
          patch admin_article_url(article), params: { article: new_attributes }, headers: headers, as: :json
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:article) { create :article }

    context 'with authentication' do
      let!(:headers) { sign_user_in }

      it 'destroys the requested article' do
        expect do
          delete admin_article_url(article), headers: headers, as: :json
        end.to change(Article, :count).by(-1)
      end
    end

    it 'returns unauthorized response' do
      expect do
        delete admin_article_url(article), headers: headers, as: :json
      end.to change(Article, :count).by(0)
      expect(response).to be_unauthorized
    end
  end
end
