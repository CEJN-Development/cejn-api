class CreateWriters < ActiveRecord::Migration[6.1]
  def change
    create_table :writers do |t|
      t.string :full_name, null: false
      t.string :slug, null: false
      t.text :byline
      t.string :cloudinary_image_url
      t.timestamps
    end

    add_index :writers, :slug
  end
end
