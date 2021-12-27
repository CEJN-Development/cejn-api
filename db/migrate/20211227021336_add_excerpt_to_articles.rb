# frozen_string_literal: true

class AddExcerptToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :excerpt, :text
  end
end
