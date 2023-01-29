# This migration comes from solidus_content_blocks (originally 20180730191800)
class AddProductsTaxonsToContentBlocks < ActiveRecord::Migration[4.2]
  def change
    remove_column :spree_content_blocks, :body_2, :text
  end
end
