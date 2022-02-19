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
require 'rails_helper'

RSpec.describe Organization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
