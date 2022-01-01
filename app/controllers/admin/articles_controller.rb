# frozen_string_literal: true

class Admin::ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    req = Article.all.select ArticlesRepository::INDEX_FIELDS
    req = req.limit index_params[:limit].to_i if index_params[:limit]
    req = req.offset index_params[:page].to_i if index_params[:page]
    res = req.order created_at: :desc
    render json: res.as_json(include: :authors), status: :ok
  end

  def show
    render json: @article.as_json(only: ArticlesRepository::SHOW_FIELDS, include: :authors), status: :ok
  end

  def create
    @article = Article.new(article_params)
    if article_authors_params[:author_ids].present? && @article.save
      article_authors_params[:author_ids].each do |id|
        @article.authors << Writer.find(id)
      end
      if photo_params[:photo].present?
        photo = Cloudinary::Uploader.upload(
          photo_params[:photo],
          { public_id: @article.slug, folder: 'articles' }
        )
        @article.update(cloudinary_image_url: photo['secure_url'])
      end
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      render json: @article, status: :ok
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
  end

  private

  def set_article
    @article = Article.find(show_params[:id])
    head(:not_found) unless @article.present?
  end

  def article_params
    params.require(:article).permit ArticlesRepository::UPDATE_PARAMS
  end

  def article_authors_params
    params.require(:article).permit ArticlesRepository::ARTICLE_AUTHORS_UPDATE_PARAMS
  end

  def index_params
    params.permit ArticlesRepository::INDEX_PARAMS
  end

  def show_params
    params.permit(:id)
  end

  def photo_params
    params.require(:article).permit(:photo)
  end
end
