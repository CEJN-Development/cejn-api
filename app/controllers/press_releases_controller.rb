# frozen_string_literal: true

# Controller for organization PressReleases
class PressReleasesController < ApplicationController
  before_action :set_press_release, only: %i[show]

  def index
    req = PressRelease.all.select PressReleasesRepository::INDEX_FIELDS
    req = req.limit index_params[:limit].to_i if index_params[:limit]
    req = req.offset index_params[:page].to_i if index_params[:page]
    res = req.order created_at: :desc
    render json: res.as_json, status: :ok
  end

  def show
    render json: @press_release, status: :ok
  end

  private

  def set_press_release
    @press_release = PressRelease.find_by(slug: show_params[:slug])
    head(:not_found) unless @press_release.present?
  end

  def index_params
    params.permit PressReleasesRepository::INDEX_PARAMS
  end

  def show_params
    params.permit(:slug)
  end
end
