# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: %i[create update destroy]

  respond_to :json

  # POST /users
  def create
    unless current_user
      return render json: { message: 'You are not authorized to create users.' }, status: :unauthorized
    end

    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      render json: { message: I18n.t('controllers.registrations.confirm') }, status: :created
    else
      render json: errors_json(resource), status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit %i[email full_name]
  end
end
