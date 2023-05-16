class CreateSpreeMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :spree_menus do |t|
      t.string :link_text
      t.string :url
      t.integer :position
      t.references :parent, foreign_key: { to_table: :spree_menus }

      t.timestamps
    end
  end
end
