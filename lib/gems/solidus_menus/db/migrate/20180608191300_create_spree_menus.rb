class CreateSpreeMenus < ActiveRecord::Migration[4.2]
  def up
    create_table :spree_menus do |t|
      t.references :menu_bar
      t.integer :sequence
      t.string :link_text
      t.string :url

      t.timestamps
    end
  end

  def down
    drop_table :spree_menus
  end
end
