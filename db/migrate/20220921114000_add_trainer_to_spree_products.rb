class AddTrainerToSpreeProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_products, :trainer_id, :integer
  end
end
  