class User < ApplicationRecord
  # include Users::Allowlist

  devise  :confirmable,
          :database_authenticatable,
          :jwt_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          jwt_revocation_strategy: self

  has_many :allowlisted_jwts, dependent: :destroy

  def for_display
    {
      email: email,
      id: id
    }
  end
end
