# frozen_string_literal: true

class Admin::WritersController < ApplicationController
  before_action :set_writer, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @writers = Writer.all
    render json: @writers.as_json(only: WritersRepository::INDEX_FIELDS), status: :ok
  end

  def show
    render json: @writer.as_json(only: WritersRepository::SHOW_FIELDS, include: :articles), status: :ok
  end

  def create
    @writer = Writer.new(writer_params)
    @writer.upload_photo photo_params[:photo] if @writer.valid?
    if @writer.save
      render json: @writer, status: :created
    else
      render json: errors_json(@writer), status: :unprocessable_entity
    end
  end

  def update
    @writer.upload_photo photo_params[:photo]
    if @writer.update(writer_params)
      render json: @writer, status: :ok
    else
      render json: errors_json(@writer), status: :unprocessable_entity
    end
  end

  def destroy
    head(:ok) if @writer.destroy
  end

  private

  def set_writer
    @writer = Writer.find_by(id: show_params[:id])
    head(:not_found) unless @writer.present?
  end

  def writer_params
    params.require(:writer).permit WritersRepository::UPDATE_PARAMS
  end

  def photo_params
    params.require(:writer).permit(:photo)
  end

  def show_params
    params.permit(:id)
  end
end
