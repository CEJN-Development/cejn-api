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
require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
