# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id                   :bigint           not null, primary key
#  title                :string
#  body                 :text
#  sample               :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  slug                 :string
#  excerpt              :text
#  cloudinary_image_url :string
#
# Indexes
#
#  index_articles_on_slug  (slug)
#
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :title, uniqueness: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :excerpt, presence: true, length: { maximum: 200 }

  before_save :sanitize_body
  before_save :truncate_body
  before_save :set_slug

  has_many :article_authors
  has_many :authors, through: :article_authors

  def sanitize_body
    self.body = ActionController::Base.helpers.sanitize(body, tags: %w[a], attributes: %w[href])
  end

  def truncate_body
    self.sample = body.length > 600 ? "#{body.truncate(600)}..." : body
  end

  def set_slug
    self.slug = make_slug
  end

  def update_authors(writer_ids)
    self.authors = [] if writer_ids.present? && authors.present?
    authors << Writer.where(id: writer_ids)
  end

  def upload_photo(photo)
    return if photo.blank?

    response = Cloudinary::Uploader.upload(photo, upload_photo_options)
    self.cloudinary_image_url = response['secure_url'] if response['secure_url'].present?
  end

  private

  def upload_photo_options
    {
      folder: 'articles',
      public_id: make_slug
    }
  end

  def make_slug
    title.parameterize
  end
end
