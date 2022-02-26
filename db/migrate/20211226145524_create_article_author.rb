class CreateArticleAuthor < ActiveRecord::Migration[6.1]
  def change
    create_table :article_authors do |t|
      t.integer :author_id, null: false
      t.integer :article_id, null: false
      t.timestamps
    end

    add_index :article_authors, %i[author_id article_id]
  end
end
