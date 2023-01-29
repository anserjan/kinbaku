# This migration comes from solidus_menus (originally 20180808181900)
class AddCssClassToSpreeMenus < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_menus, :css_class, :string, default: ""
  end
end
