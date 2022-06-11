# frozen_string_literal: true

class UsersRepository
  INDEX_FIELDS = %i[
    email
    created_at
    id
    updated_at
  ].freeze

  INDEX_PARAMS = %i[
    limit
    page
  ].freeze

  UPDATE_PARAMS = %i[
    email
  ].freeze
end
