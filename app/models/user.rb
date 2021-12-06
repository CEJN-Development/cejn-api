class User < ApplicationRecord
  # include Users::Allowlist

  devise  :database_authenticatable,
          :jwt_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          jwt_revocation_strategy: self
end
