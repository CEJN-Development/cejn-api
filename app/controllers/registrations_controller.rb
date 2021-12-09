# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action configure_sign_up_params, only: %i[create]

  def create
    @user = User.new(sign_up_params)
    @user.save
    if @user.persisted?
      render json: @user, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name])
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :full_name
    )
  end
end
