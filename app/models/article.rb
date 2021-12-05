# frozen_string_literal: true

# Articles published by the organization
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { minimum: 10 }

  before_save :truncate_body
  before_save :set_slug

  def truncate_body
    self.sample = "#{body.truncate(600)}..."
  end

  def set_slug
    self.slug = title.truncate(50).parameterize
  end
end
