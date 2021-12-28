# frozen_string_literal: true

class Admin::WritersController < ApplicationController
  before_action :set_writer, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @writers = Writer.all
    render json: @writers.as_json(only: WritersRepository::INDEX_FIELDS), status: :ok
  end

  def show
    render json: @writer.as_json(only: WritersRepository::SHOW_FIELDS), status: :ok
  end

  def create
    @writer = Writer.new(writer_params)
    if @writer.save
      if photo_params[:photo].present?
        photo = Cloudinary::Uploader.upload(
          photo_params[:photo],
          { public_id: @writer.slug, folder: 'writers' }
        )
        @writer.update(cloudinary_image_url: photo['secure_url'])
      end
      render json: @writer, status: :created
    else
      render json: @writer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @writer.update(writer_params)
      render json: @writer, status: :ok
    else
      render json: @writer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @writer.destroy
  end

  private

  def set_writer
    @writer = Writer.find_by(slug: show_params[:slug])
    head(:not_found) unless @writer.present?
  end

  def writer_params
    params.require(:writer).permit WritersRepository::UPDATE_PARAMS
  end

  def photo_params
    params.require(:writer).permit(:photo)
  end

  def show_params
    params.permit(:slug)
  end
end
