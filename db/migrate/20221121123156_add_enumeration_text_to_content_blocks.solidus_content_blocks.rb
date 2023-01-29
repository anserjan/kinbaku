# This migration comes from solidus_content_blocks (originally 20190213015001)
class AddEnumerationTextToContentBlocks < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_content_blocks, :enumeration_text, :string
  end
end
