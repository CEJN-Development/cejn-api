# frozen_string_literal: true

class Admin::OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @organizations = Organization.all
    render json: @organizations.as_json(only: OrganizationsRepository::INDEX_FIELDS), status: :ok
  end

  def show
    render json: @organization.as_json(only: OrganizationsRepository::SHOW_FIELDS), status: :ok
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.upload_photo photo_params[:photo] if @organization.valid?
    if @organization.save
      render json: @organization, status: :created
    else
      render json: errors_json(@organization), status: :unprocessable_entity
    end
  end

  def update
    @organization.upload_photo photo_params[:photo]
    if @organization.update(organization_params)
      render json: @organization, status: :ok
    else
      render json: errors_json(@organization), status: :unprocessable_entity
    end
  end

  def destroy
    render json: {}, status: :ok if @organization.destroy
  end

  private

  def set_organization
    @organization = Organization.find_by(id: show_params[:id])
    head(:not_found) unless @organization.present?
  end

  def organization_params
    params.require(:organization).permit OrganizationsRepository::UPDATE_PARAMS
  end

  def photo_params
    params.require(:organization).permit(:photo)
  end

  def show_params
    params.permit(:id)
  end
end
