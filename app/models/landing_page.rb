class LandingPage < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :preview, presence: true
  validates :body, presence: true

  before_save :set_slug

  def set_slug
    self.slug = make_slug
  end

  private

  def make_slug
    name.parameterize
  end
end
