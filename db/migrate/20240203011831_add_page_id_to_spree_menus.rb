class AddPageIdToSpreeMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_menus, :page_id, :integer
    add_index :spree_menus, :page_id
  end
end
