# frozen_string_literal: true

# Controller for member organizations
class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show update destroy]

  def index
    @organizations = Organization.all
    render json: @organizations.as_json(only: OrganizationsRepository::INDEX_FIELDS), status: :ok
  end

  def show
    render json: @organization.as_json(only: OrganizationsRepository::SHOW_FIELDS), status: :ok
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render :show, status: :created, location: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def update
    if @organization.update(organization_params)
      render :show, status: :ok, location: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy
  end

  private

  def set_organization
    @organization = Organization.find_by(slug: show_params[:slug])
    head(:not_found) unless @organization.present?
  end

  def organization_params
    params.fetch(:organization, {})
  end

  def show_params
    params.permit(:slug)
  end
end
