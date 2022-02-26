# frozen_string_literal: true

class InsertStaffArticlesAndAboutIntoSplashSections < ActiveRecord::Migration[6.1]
  def up
    section_names = %w[about staff articles]
    SplashSection.transaction do
      section_names.each_with_index do |section_name, index|
        SplashSection.create(name: section_name, priority: index)
      end
    end
  end

  def down
    section_names = %w[about staff articles]
    SplashSection.where(name: section_names).destroy_all
  end
end
