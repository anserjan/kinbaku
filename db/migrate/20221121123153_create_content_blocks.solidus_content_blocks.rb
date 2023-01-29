# This migration comes from solidus_content_blocks (originally 20180727165300)
class CreateContentBlocks < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_content_blocks do |t|

      t.integer :page_id, index: true, foreign_key: true

      t.string :content_type
      t.string :block_name
      t.text :body_1
      t.text :body_2
      t.boolean :visible, default: false
      t.integer :position, default: 0

      t.timestamps null: false
    end

  end
end
