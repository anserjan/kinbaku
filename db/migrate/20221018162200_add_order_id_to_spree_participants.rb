class AddOrderIdToSpreeParticipants < SolidusSupport::Migration[4.2]
  def change
    add_column :spree_participants, :order_id, :integer
  end
end