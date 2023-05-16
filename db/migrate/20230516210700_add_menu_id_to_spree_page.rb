class AddMenuIdToSpreePage < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_pages, :menu_id, :integer
  end
end
