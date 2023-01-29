class AddParticipantIdToSpreeOrders < ActiveRecord::Migration[5.2]
    def change
        add_column :spree_orders, :participant_id, :integer
    end
end
  