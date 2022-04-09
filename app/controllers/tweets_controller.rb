# frozen_string_literal: true

# Controller for interacting with twitter API
class TweetsController < ApplicationController
  def timeline
    render json: JSON.parse(TwitterApi.new.timeline(timeline_options))
  end

  private

  def timeline_options
    {}.merge timeline_params
  end

  def timeline_params
    params.permit %i[
      contributor_details
      count
      exclude_replies
      include_rts
      max_id
      since_id
    ]
  end
end
