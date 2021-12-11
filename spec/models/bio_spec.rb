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
require 'rails_helper'

RSpec.describe Bio, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
