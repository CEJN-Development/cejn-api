# frozen_string_literal: true

# Controller for organization Articles
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  before_action :authenticate_user, only: %i[create update destroy]

  def index
    req = Article.all.select ArticlesRepository::INDEX_FIELDS
    req = req.limit index_params[:limit].to_i if index_params[:limit]
    req = req.offset index_params[:page].to_i if index_params[:page]
    res = req.order created_at: :desc
    render json: res, status: :ok
  end

  def show
    render json: @article.as_json(only: ArticlesRepository::SHOW_FIELDS), status: :ok
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render :show, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      render :show, status: :ok, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
  end

  private

  def set_article
    @article = Article.find_by(slug: show_params[:slug])
    head(:not_found) unless @article.present?
  end

  def article_params
    params.require(:article).permit ArticlesRepository::UPDATE_PARAMS
  end

  def index_params
    params.permit ArticlesRepository::INDEX_PARAMS
  end

  def show_params
    params.permit(:slug)
  end
end
