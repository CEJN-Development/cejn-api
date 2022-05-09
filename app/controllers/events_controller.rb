class EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]

  def index
    render json: Event.all.as_json, status: :ok
  end

  def next
    render json: Event.where('date >= ?', DateTime.now).order(:date).limit(1).as_json
  end

  def show
    render json: @event, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:slug])
  end

  def index_params
    params.permit EventsRepository::INDEX_PARAMS
  end

  def show_params
    params.permit(:slug)
  end
end
