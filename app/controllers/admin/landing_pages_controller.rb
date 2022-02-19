# frozen_string_literal: true

class Admin::LandingPagesController < ApplicationController
  before_action :set_landing_page, only: %i[show update]
  before_action :authenticate_user!, only: %i[update]

  def show
    render json: @landing_page.as_json(only: LandingPagesRepository::SHOW_FIELDS), status: :ok
  end

  def update
    if @landing_page.update(landing_page_params)
      render json: @landing_page, status: :ok
    else
      render json: @landing_page.errors, status: :unprocessable_entity
    end
  end

  private

  def show_params
    params.permit LandingPagesRepository::SHOW_PARAMS
  end

  def landing_page_params
    params.require(:landing_page).permit LandingPagesRepository::UPDATE_PARAMS
  end

  def set_landing_page
    @landing_page = LandingPage.find_by(slug: show_params[:slug])
    head(:not_found) unless @landing_page.present?
  end
end
