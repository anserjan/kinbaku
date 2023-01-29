class AddSpreeParticipantsCountToSpreeProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :spree_products, :participants_count, :integer
  end
end
