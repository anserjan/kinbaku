class AddSpreeParticipantsToSpreeProducts < ActiveRecord::Migration[5.2]
    def change
        add_column :spree_products, :participant_id, :integer
    end
end
  