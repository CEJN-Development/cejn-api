# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.datetime :date, null: false
      t.string :cloudinary_image_url
      t.string :name, null: false
      t.string :slug
      t.text :body
      t.text :description
      t.timestamps
    end

    add_index :events, :slug
  end
end
