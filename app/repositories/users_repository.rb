# frozen_string_literal: true

class UsersRepository
  INDEX_FIELDS = %i[
    email
    full_name
    created_at
    id
    short_name
    updated_at
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
  ].freeze

  UPDATE_PARAMS = %i[
    email
    full_name
    short_name
  ].freeze
end
