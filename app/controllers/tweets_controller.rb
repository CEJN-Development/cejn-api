# frozen_string_literal: true

# Controller for interacting with twitter API
class TweetsController < ApplicationController
  def timeline(options = {})
    render json: JSON.parse(TwitterApi.timeline(options))
  end
end
