# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_by_confirmation_params, only: %i[set_password]

  respond_to :json

  def set_password
    token = @user.send(:set_reset_password_token)
    render json: { password_reset_token: token }
  end

  private

  def users_options
    {}.merge timeline_params
  end

  def find_by_confirmation_params
    @user = User.find_by(confirmation_params)
    render json: { message: 'User not found.' }, status: :unauthorized if @user.nil?
  end

  def confirmation_params
    params.require(:user)
          .permit %i[
            email
            confirmation_token
          ]
  end
end
