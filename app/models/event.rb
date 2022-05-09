# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  date                 :datetime         not null
#  cloudinary_image_url :string
#  name                 :string           not null
#  slug                 :string
#  body                 :text
#  description          :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_events_on_slug  (slug)
#
class Event < ApplicationRecord
  validates :body, presence: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :name, presence: true
  validates :name, uniqueness: true

  before_save :set_slug

  private

  def set_slug
    self.slug = name.parameterize
  end
end
