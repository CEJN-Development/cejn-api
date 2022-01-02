# frozen_string_literal: true

class Admin::BiosController < ApplicationController
  before_action :set_bio, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @bios = Bio.all
    render json: @bios.as_json(only: BiosRepository::INDEX_FIELDS), status: :ok
  end

  def show
    render json: @bio.as_json(only: BiosRepository::SHOW_FIELDS, include: :articles), status: :ok
  end

  def create
    @bio = Bio.new(bio_params)
    @bio.upload_photo photo_params[:photo] if @bio.valid?
    if @bio.save
      render json: @bio, status: :created
    else
      render json: @bio.errors, status: :unprocessable_entity
    end
  end

  def update
    @bio.upload_photo photo_params[:photo]
    if @bio.update(bio_params)
      render json: @bio, status: :ok
    else
      render json: @bio.errors, status: :unprocessable_entity
    end
  end

  def destroy
    head(:ok) if @bio.destroy
  end

  private

  def set_bio
    @bio = Bio.find_by(id: show_params[:id])
    head(:not_found) unless @bio.present?
  end

  def bio_params
    params.require(:bio).permit BiosRepository::UPDATE_PARAMS
  end

  def photo_params
    params.require(:bio).permit(:photo)
  end

  def show_params
    params.permit(:id)
  end
end
