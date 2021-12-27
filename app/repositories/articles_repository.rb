# frozen_string_literal: true

class ArticlesRepository
  INDEX_FIELDS = %i[
    created_at
    id
    excerpt
    sample
    title
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
    excerpt
    id
    title
    updated_at
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    body
    excerpt
    title
  ].freeze
end
