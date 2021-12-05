# frozen_string_literal: true

class BiosRepository
  INDEX_FIELDS = %i[
    blurb
    created_at
    id
    name
    updated_at
    slug
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
  ].freeze

  SHOW_FIELDS = %i[
    body
    created_at
    id
    name
    updated_at
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    body
    name
  ].freeze
end
