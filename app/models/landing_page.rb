# frozen_string_literal: true

# == Schema Information
#
# Table name: landing_pages
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  preview    :text
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_landing_pages_on_slug  (slug)
#
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
