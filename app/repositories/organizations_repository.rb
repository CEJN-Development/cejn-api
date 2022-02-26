# frozen_string_literal: true

class OrganizationsRepository
  INDEX_FIELDS = %i[
    blurb
    cloudinary_image_url
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
    blurb
    cloudinary_image_url
    created_at
    id
    name
    updated_at
    slug
  ].freeze

  UPDATE_PARAMS = %i[
    blurb
    body
    name
  ].freeze
end
