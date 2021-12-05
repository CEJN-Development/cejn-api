# frozen_string_literal: true

# create table for network member biographies
class CreateBios < ActiveRecord::Migration[6.1]
  def change
    create_table :bios do |t|
      t.text :blurb
      t.text :body
      t.string :name
      t.string :slug
      t.timestamps
    end

    add_index :bios, :slug
  end
end
