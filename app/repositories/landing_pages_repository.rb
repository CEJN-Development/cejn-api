# frozen_string_literal: true

class LandingPagesRepository
  SHOW_FIELDS = %i[
    body
    name
    preview
    slug
  ].freeze

  SHOW_PARAMS = %i[
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    body
    name
    preview
  ].freeze
end
