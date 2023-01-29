class AddEnumerationTextToContentBlocks < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_content_blocks, :enumeration_text, :string
  end
end
