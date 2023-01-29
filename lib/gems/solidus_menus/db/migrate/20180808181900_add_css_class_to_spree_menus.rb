class AddCssClassToSpreeMenus < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_menus, :css_class, :string, default: ""
  end
end
