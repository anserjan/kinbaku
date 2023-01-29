class AddPaymentStatusToSpreeParticipants < ActiveRecord::Migration[5.2]
    def change
        add_column :spree_participants, :payment_status, :boolean, default: false
    end
end
  