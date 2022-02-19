# frozen_string_literal: true

class LandingPagesController < ApplicationController
  before_action :set_landing_page, only: %i[show]

  def show
    render json: @landing_page.as_json(only: LandingPagesRepository::SHOW_FIELDS), status: :ok
  end

  private

  def set_landing_page
    @landing_page = LandingPage.find_by(slug: show_params[:slug])
    head(:not_found) unless @landing_page.present?
  end

  def show_params
    params.permit(:slug)
  end
end
