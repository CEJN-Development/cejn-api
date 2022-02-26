class RenameBiosToOrganizations < ActiveRecord::Migration[6.1]
  def change
    rename_table :bios, :organizations
  end
end
