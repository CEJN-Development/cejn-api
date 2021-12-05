class BiosController < ApplicationController
  before_action :set_bio, only: %i[show update destroy]

  def index
    @bios = Bio.all
  end

  def show
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
    @bio = Bio.find_by(slug: params[:slug])
    head(:not_found) unless @bio.present?
  end

  def bio_params
    params.fetch(:bio, {})
  end
end
