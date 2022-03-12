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
require 'rails_helper'

RSpec.describe PressRelease, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
