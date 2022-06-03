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
  validates :date, presence: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :name, presence: true
  validates :name, uniqueness: true

  before_save :set_slug

  def set_slug
    self.slug = make_slug
  end

  def upload_photo(photo)
    return if photo.blank?

    response = Cloudinary::Uploader.upload(photo, upload_photo_options)
    self.cloudinary_image_url = response['secure_url'] if response['secure_url'].present?
  end

  private

  def upload_photo_options
    {
      folder: 'events',
      public_id: make_slug
    }
  end

  def make_slug
    name.parameterize
  end
end
