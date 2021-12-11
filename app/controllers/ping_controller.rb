class PingController < ApplicationController
  before_action :authenticate_user!, only: %i[auth]

  def index
    render body: nil, status: 200
  end

  def auth
    render body: nil, status: 200
  end
end