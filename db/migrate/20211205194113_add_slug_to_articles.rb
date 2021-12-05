# frozen_string_literal: true

# create url friendly slugs for articles
class AddSlugToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :slug, :string
    add_index :articles, :slug
  end
end
