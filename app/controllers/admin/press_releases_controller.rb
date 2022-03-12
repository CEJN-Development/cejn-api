# frozen_string_literal: true

class Admin::PressReleasesController < ApplicationController
  before_action :set_press_release, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    req = PressRelease.all.select PressReleasesRepository::INDEX_FIELDS
    req = req.limit index_params[:limit].to_i if index_params[:limit]
    req = req.offset index_params[:page].to_i if index_params[:page]
    render json: req.order(created_at: :desc), status: :ok
  end

  def show
    render json: @press_release.as_json(only: PressReleasesRepository::SHOW_FIELDS), status: :ok
  end

  def create
    @press_release = PressRelease.new(press_release_params)
    if @press_release.save
      render json: @press_release, status: :created
    else
      render json: errors_json(@press_release), status: :unprocessable_entity
    end
  end

  def update
    if @press_release.update(press_release_params)
      render json: @press_release.as_json, status: :ok
    else
      render json: errors_json(@press_release), status: :unprocessable_entity
    end
  end

  def destroy
    render json: {}, status: :ok if @press_release.destroy
  end

  private

  def set_press_release
    @press_release = PressRelease.find(show_params[:id])
    head(:not_found) unless @press_release.present?
  end

  def press_release_params
    params.require(:press_release).permit PressReleasesRepository::UPDATE_PARAMS
  end

  def index_params
    params.permit PressReleasesRepository::INDEX_PARAMS
  end

  def show_params
    params.permit(:id)
  end
end
