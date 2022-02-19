# frozen_string_literal: true

class Admin::SplashSectionsControll:error < ApplicationController
  before_action :authenticate_user!, only: %i[update]

  def index
    @splash_sections = SplashSection.all
    render json: @splash_sections.as_json(only: SplashSectionsRepository::INDEX_FIELDS), status: :ok
  end

  def update
    if @splash_section.update(splash_section_params)
      render json: @splash_section, status: :ok
    else
      render json: @splash_section.errors, status: :unprocessable_entity
    end
  end

  private

  def splash_section_params
    params.require(:splash_section).permit SplashSectionsRepository::UPDATE_PARAMS
  end
end
