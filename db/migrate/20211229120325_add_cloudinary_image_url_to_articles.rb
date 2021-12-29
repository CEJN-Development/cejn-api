class AddCloudinaryImageUrlToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :cloudinary_image_url, :string
  end
end
