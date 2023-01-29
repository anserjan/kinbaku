class AddProductsTaxonsReferencesToContentBlocks < ActiveRecord::Migration[4.2]
  def change
    add_reference :spree_content_blocks, :product, index: true
    add_reference :spree_content_blocks, :taxon, index: true
  end
end
