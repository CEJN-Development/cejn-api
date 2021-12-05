# frozen_string_literal: true

# Records of the members of the organization
class Bio < ApplicationRecord
  validates :name, presence: true
  validates :body, presence: true
  validates :blurb, presence: true

  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end
end
