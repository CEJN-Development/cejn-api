# frozen_string_literal: true

class EventsRepository
  INDEX_FIELDS = %i[
    body
    cloudinary_image_url
    created_at
    date
    description
    id
    name
    updated_at
    slug
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
    include_expired
  ].freeze

  SHOW_FIELDS = %i[
    body
    cloudinary_image_url
    created_at
    date
    description
    id
    name
    updated_at
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    body
    date
    description
    name
  ].freeze
end
