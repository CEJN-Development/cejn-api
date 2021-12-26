# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string
#  body       :text
#  sample     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
# Indexes
#
#  index_articles_on_slug  (slug)
#
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { minimum: 10 }

  before_save :truncate_body
  before_save :set_slug

  has_many :article_authors
  has_many :authors, through: :article_authors

  def truncate_body
    self.sample = body.length <= 600 ? "#{body.truncate(600)}..." : body
  end

  def set_slug
    self.slug = title.truncate(50).parameterize
  end
end
