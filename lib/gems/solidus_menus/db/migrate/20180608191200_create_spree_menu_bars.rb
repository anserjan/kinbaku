class CreateSpreeMenuBars < ActiveRecord::Migration[4.2]
  def up
    create_table :spree_menu_bars, :force => true do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :spree_menu_bars
  end
end
