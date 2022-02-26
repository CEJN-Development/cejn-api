class CreateSplashSections < ActiveRecord::Migration[6.1]
  def change
    create_table :splash_sections do |t|
      t.string :name, null: false
      t.integer :priority, null: false
      t.timestamps
    end
  end
end
