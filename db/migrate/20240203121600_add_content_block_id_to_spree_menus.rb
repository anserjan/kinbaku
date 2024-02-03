class AddContentBlockIdToSpreeMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_menus, :content_block_id, :integer
    add_index :spree_menus, :content_block_id
  end
end
