# frozen_string_literal: true

class Admin::EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @events = Event.all
    render json: @events.as_json(only: EventsRepository::INDEX_FIELDS), status: :ok
  end

  def show
    render json: @event.as_json(only: EventsRepository::SHOW_FIELDS), status: :ok
  end

  def create
    @event = Event.new(event_params)
    @event.upload_photo photo_params[:photo] if @event.valid?
    if @event.save
      render json: @event, status: :created
    else
      render json: errors_json(@event), status: :unprocessable_entity
    end
  end

  def update
    @event.upload_photo photo_params[:photo]
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: errors_json(@event), status: :unprocessable_entity
    end
  end

  def destroy
    render json: {}, status: :ok if @event.destroy
  end

  private

  def set_event
    @event = Event.find_by(id: show_params[:id])
    head(:not_found) unless @event.present?
  end

  def event_params
    params.require(:event).permit EventsRepository::UPDATE_PARAMS
  end

  def photo_params
    params.require(:event).permit(:photo)
  end

  def show_params
    params.permit(:id)
  end
end
