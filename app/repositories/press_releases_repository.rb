# frozen_string_literal: true

class PressReleasesRepository
  INDEX_FIELDS = %i[
    created_at
    id
    summary
    title
    slug
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
  ].freeze

  SHOW_FIELDS = %i[
    body
    created_at
    summary
    id
    title
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    body
    summary
    title
  ].freeze
end
