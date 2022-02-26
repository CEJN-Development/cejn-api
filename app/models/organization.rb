# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id                   :bigint           not null, primary key
#  blurb                :text
#  body                 :text
#  name                 :string
#  slug                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  cloudinary_image_url :string
#
# Indexes
#
#  index_organizations_on_slug  (slug)
#
class Organization < ApplicationRecord
  validates :name, presence: true
  validates :body, presence: true
  validates :blurb, presence: true

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
      folder: 'organizations',
      public_id: make_slug
    }
  end

  def make_slug
    name.parameterize
  end
end
