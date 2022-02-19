# frozen_string_literal: true

class InsertAboutUsIntoLandingPages < ActiveRecord::Migration[6.1]
  def up
    LandingPage
      .where(name: "About Us")
      .first_or_initialize
      .save(validate: false)
  end

  def down
    landing_page = LandingPage.find_by(name: "About Us")
    landing_page.destroy! if landing_page.present?
  end
end
