class CreateSpreeContentImages < ActiveRecord::Migration[7.0]

  def change
    create_table :spree_content_images do |t|
      t.integer :position, default: 0, null: false
      t.string :alt
      t.integer :content_block_id
    end
  end

end