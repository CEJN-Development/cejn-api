# frozen_string_literal: true

class ArticlesRepository
  INDEX_FIELDS = %i[
    cloudinary_image_url
    created_at
    id
    excerpt
    sample
    title
    slug
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
  ].freeze

  SHOW_FIELDS = %i[
    body
    cloudinary_image_url
    created_at
    excerpt
    id
    title
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    body
    excerpt
    title
  ].freeze

  AUTHORS_PARAMS = [
    author_ids: []
  ].freeze
end
