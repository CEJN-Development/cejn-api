class BiosController < ApplicationController
  before_action :set_bio, only: %i[show update destroy]

  def index
    @bios = Bio.all
    render json: @bios.as_json(only: BiosRepository::INDEX_FIELDS), status: :ok
  end

  def show
    render json: @bio.as_json(only: BiosRepository::SHOW_FIELDS), status: :ok
  end

  def create
    @bio = Bio.new(bio_params)

    if @bio.save
      render :show, status: :created, location: @bio
    else
      render json: @bio.errors, status: :unprocessable_entity
    end
  end

  def update
    if @bio.update(bio_params)
      render :show, status: :ok, location: @bio
    else
      render json: @bio.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bio.destroy
  end

  private

  def set_bio
    @bio = Bio.find_by(slug: show_params[:slug])
    head(:not_found) unless @bio.present?
  end

  def bio_params
    params.fetch(:bio, {})
  end

  def show_params
    params.permit(:slug)
  end
end
