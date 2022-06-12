# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  respond_to :json

  def update
    if @user.update(user_params)
      render json: @user.as_json(only: UsersRepository::INDEX_FIELDS), status: :ok
    else
      render json: errors_json(@user), status: :unprocessable_entity
    end
  end

  def destroy
    render json: {}, status: :ok if @user.destroy
  end

  def team
    render json: User.all.as_json(only: UsersRepository::INDEX_FIELDS), status: :ok
  end

  private

  def set_user
    @user = User.find_by(id: show_params[:id])
    head(:not_found) unless @user.present?
  end

  def user_params
    params.require(:user).permit UsersRepository::UPDATE_PARAMS
  end

  def show_params
    params.permit(:id)
  end
end
