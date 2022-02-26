class CreateLandingPages < ActiveRecord::Migration[6.1]
  def change
    create_table :landing_pages do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :preview
      t.text :body
      t.timestamps
    end

    add_index :landing_pages, :slug
  end
end
