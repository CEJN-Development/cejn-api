# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "/admin/articles", type: :request do
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
      expect(response).to be_successful
      expect(json.length).to eq 5
    end
  end

  describe 'GET /show' do
    let!(:article) { create :article }

    it 'renders a successful response' do
      get admin_article_url(article), as: :json
      expect(response).to be_successful
      expect(json['id']).to eq article.id
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      xit 'creates a new Article' do
        expect do
          post admin_articles_url,
               params: { article: valid_params }, as: :json
        end.to change(Article, :count).by 1
      end

      xit 'renders a JSON response with the new article' do
        post admin_articles_url, params: { article: valid_params }, as: :json
        expect(response).to have_http_status :created
        expect(response.content_type).to match a_string_including('application/json')
        expect(json['title']).to eq valid_params[:title]
        expect(json['body']).to eq valid_params[:body]
        expect(json['excerpt']).to eq valid_params[:excerpt]
        expect(json['slug']).to eq valid_params[:title].parameterize
      end
    end

    context 'with invalid parameters' do
      let!(:invalid_params) { valid_params.merge({ body: nil }) }

      xit 'does not create a new Article' do
        expect do
          post admin_articles_url, params: { article: invalid_params }, as: :json
        end.to change(Article, :count).by(0)
      end

      xit 'renders a JSON response with errors for the new article' do
        post admin_articles_url, params: { article: invalid_params }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match a_string_including('application/json')
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

      context "with authentication" do
        let!(:user) { create_user }
        let!(:user_jwt) { get_jwt_cookie(User.last.email) }
        let(:headers) { headers_with_http_cookie(user_jwt) }

        before(:each) do
          my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
          my_cookies[:jwt] = user_jwt
          cookies[:jwt] = my_cookies[:jwt]
        end

        it 'updates the requested article' do
          patch admin_article_url(article), params: { article: new_attributes }, headers: headers, as: :json
          expect(article.reload.title).to eq new_attributes[:title]
          expect(article.reload.body).to eq new_attributes[:body]
          expect(article.reload.excerpt).to eq new_attributes[:excerpt]
        end

        it 'renders a JSON response with the article' do
          patch admin_article_url(article), params: { article: new_attributes }, headers: headers, as: :json
          expect(response).to have_http_status :ok
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
    end
  end

  describe 'DELETE /destroy' do
    let!(:article) { create :article }

    xit 'destroys the requested article' do
      expect do
        delete admin_article_url(article), as: :json
      end.to change(Article, :count).by(-1)
    end
  end
end
