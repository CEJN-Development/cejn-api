# frozen_string_literal: true

# == Schema Information
#
# Table name: press_releases
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  slug       :string           not null
#  body       :text
#  summary    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_press_releases_on_slug  (slug)
#
class PressRelease < ApplicationRecord
  validates :title, uniqueness: true
  validates :title, presence: true, length: { maximum: 70 }
  validates :summary, presence: true, length: { maximum: 200 }
  validates :body, presence: true

  before_save :sanitize_body
  before_save :set_slug

  def sanitize_body
    self.body = ActionController::Base.helpers.sanitize(body, tags: %w[a b], attributes: %w[href target])
  end

  def set_slug
    self.slug = make_slug
  end

  private

  def make_slug
    title.parameterize
  end
end
