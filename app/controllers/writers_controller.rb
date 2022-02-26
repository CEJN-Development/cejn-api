# frozen_string_literal: true

class WritersController < ApplicationController
  before_action :set_writer, only: %i[show]

  def show
    render json: @writer.as_json(only: WritersRepository::SHOW_FIELDS, include: :articles), status: :ok
  end

  private

  def set_writer
    @writer = Writer.find_by(slug: show_params[:slug])
    head(:not_found) unless @writer.present?
  end

  def show_params
    params.permit(:slug)
  end
end
