class RenameBiosToOrganizations < ActiveRecord::Migration[6.1]
  def change
    rename_table :organizations, :organizations
  end
end
