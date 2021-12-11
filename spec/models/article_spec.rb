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
require 'rails_helper'

RSpec.describe Article, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
