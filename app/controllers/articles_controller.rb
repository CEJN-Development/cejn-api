# frozen_string_literal: true

# Controller for organization Articles
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show]

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

  private

  def set_article
    @article = Article.find_by(slug: show_params[:slug])
    head(:not_found) unless @article.present?
  end

  def index_params
    params.permit ArticlesRepository::INDEX_PARAMS
  end

  def show_params
    params.permit(:slug)
  end
end
