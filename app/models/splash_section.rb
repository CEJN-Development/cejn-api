# frozen_string_literal: true

# == Schema Information
#
# Table name: splash_sections
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  priority   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SplashSection < ApplicationRecord
  validates :priority, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
