class AddTaxonIdToSpreeContentBlocks < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_content_blocks, :taxon_id, :integer
    add_index :spree_content_blocks, :taxon_id
  end
end
