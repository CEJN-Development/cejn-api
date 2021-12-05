# frozen_string_literal: true

class ArticlesRepository
  INDEX_FIELDS = %i[
    created_at
    id
    sample
    title
    updated_at
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
  ].freeze

  SHOW_FIELDS = %i[
    body
    created_at
    id
    title
    updated_at
  ].freeze

  UPDATE_PARAMS = %i[
    body
    title
  ].freeze
end
