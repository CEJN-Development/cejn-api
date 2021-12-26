# frozen_string_literal: true

class BiosRepository
  INDEX_FIELDS = %i[
    byline
    cloudinary_image_url
    created_at
    id
    full_name
    updated_at
    slug
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
  ].freeze

  SHOW_FIELDS = %i[
    byline
    cloudinary_image_url
    created_at
    id
    full_name
    updated_at
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    byline
    full_name
  ].freeze
end
