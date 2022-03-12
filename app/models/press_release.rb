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
class PressRelease < ApplicationRecord
end
