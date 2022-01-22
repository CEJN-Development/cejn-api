# frozen_string_literal: true

class SplashSectionsController < ApplicationController
  def index
    render json: SplashSection.all.as_json(only: SplashSectionsRepository::INDEX_FIELDS), status: :ok
  end
end
