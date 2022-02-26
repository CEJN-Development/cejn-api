class AddCaptionToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :caption, :string
  end
end
