class AddCloudinaryImageUrlToBios < ActiveRecord::Migration[6.1]
  def change
    add_column :bios, :cloudinary_image_url, :string
  end
end
