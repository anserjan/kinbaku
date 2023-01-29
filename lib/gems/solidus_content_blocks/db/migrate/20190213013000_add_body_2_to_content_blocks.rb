class AddBody2ToContentBlocks < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_content_blocks, :body_2, :text
  end
end
