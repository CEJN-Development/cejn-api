# frozen_string_literal: true

# == Schema Information
#
# Table name: bios
#
#  id         :bigint           not null, primary key
#  blurb      :text
#  body       :text
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bios_on_slug  (slug)
#
class Bio < ApplicationRecord
  validates :name, presence: true
  validates :body, presence: true
  validates :blurb, presence: true

  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end
end
