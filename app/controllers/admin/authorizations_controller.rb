# frozen_string_literal: true

class Admin::AuthorizationsController < ApplicationController
  before_action :authenticate_user!, only: %i[authorization]

  def authorization
    render json: true
  end
end
