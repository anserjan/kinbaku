class AddStateToSpreeParticipants < ActiveRecord::Migration[7.0]

  def change
    add_column :spree_participants, :state, :string
  end

end