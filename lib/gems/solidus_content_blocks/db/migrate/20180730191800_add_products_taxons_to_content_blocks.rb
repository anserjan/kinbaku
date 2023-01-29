class AddProductsTaxonsToContentBlocks < ActiveRecord::Migration[4.2]
  def change
    remove_column :spree_content_blocks, :body_2, :text
  end
end
