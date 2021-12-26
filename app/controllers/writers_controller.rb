# frozen_string_literal: true

class WritersController < ApplicationController
  before_action :set_writer, only: %i[show update destroy]

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
      render :show, status: :created, location: @writer
    else
      render json: @writer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @writer.update(writer_params)
      render :show, status: :ok, location: @writer
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
    params.fetch(:writer, {})
  end

  def show_params
    params.permit(:slug)
  end
end
