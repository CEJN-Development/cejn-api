# frozen_string_literal: true

class Admin::ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :require_author, only: %i[create]

  def index
    req = Article.all.select ArticlesRepository::INDEX_FIELDS
    req = req.limit index_params[:limit].to_i if index_params[:limit]
    req = req.offset index_params[:page].to_i if index_params[:page]
    render json: req.order(created_at: :desc).as_json(include: :authors), status: :ok
  end

  def show
    render json: @article.as_json(only: ArticlesRepository::SHOW_FIELDS, include: :authors), status: :ok
  end

  def create
    @article = Article.new(article_params)
    @article.update_authors authors_params[:author_ids] if @article.valid?
    @article.upload_photo photo_params[:photo] if @article.valid?
    if @article.save
      render json: @article.as_json(include: :authors), status: :created
    else
      render json: errors_json(@article), status: :unprocessable_entity
    end
  end

  def update
    @article.update_authors authors_params[:author_ids]
    @article.upload_photo photo_params[:photo] if @article.valid?
    if @article.update(article_params)
      render json: @article.as_json(include: :authors), status: :ok
    else
      render json: errors_json(@article), status: :unprocessable_entity
    end
  end

  def destroy
    render json: {}, status: :ok if @article.destroy
  end

  private

  def set_article
    @article = Article.find(show_params[:id])
    head(:not_found) unless @article.present?
  end

  def article_params
    params.require(:article).permit ArticlesRepository::UPDATE_PARAMS
  end

  def authors_params
    params.require(:article).permit ArticlesRepository::AUTHORS_PARAMS
  end

  def require_author
    error = { message: 'An author is required.' }
    return render json: error, status: :unprocessable_entity if authors_params[:author_ids].blank?
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
