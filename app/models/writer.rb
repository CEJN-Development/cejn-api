# frozen_string_literal: true

# == Schema Information
#
# Table name: writers
#
#  id                   :bigint           not null, primary key
#  full_name            :string           not null
#  slug                 :string           not null
#  byline               :text
#  cloudinary_image_url :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_writers_on_slug  (slug)
#
class Writer < ApplicationRecord
  validates :full_name, presence: true
  validates :byline, presence: true

  before_save :set_slug

  has_many :article_authors, foreign_key: :author_id
  has_many :articles, through: :article_authors

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
      folder: 'writers',
      public_id: make_slug
    }
  end

  def make_slug
    full_name.parameterize
  end
end
