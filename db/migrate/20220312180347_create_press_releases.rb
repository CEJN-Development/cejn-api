# frozen_string_literal: true

class CreatePressReleases < ActiveRecord::Migration[6.1]
  def change
    create_table :press_releases do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body
      t.text :summary
      t.timestamps
    end

    add_index :press_releases, :slug
  end
end
