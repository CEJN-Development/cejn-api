# frozen_string_literal: true

class SplashSection < ApplicationRecord
  validates :priority, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
