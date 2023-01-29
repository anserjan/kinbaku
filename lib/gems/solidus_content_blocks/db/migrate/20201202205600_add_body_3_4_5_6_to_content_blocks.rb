class AddBody3456ToContentBlocks < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_content_blocks, :body_3, :text
    add_column :spree_content_blocks, :body_4, :text
    add_column :spree_content_blocks, :body_5, :text
    add_column :spree_content_blocks, :body_6, :text
  end
end
