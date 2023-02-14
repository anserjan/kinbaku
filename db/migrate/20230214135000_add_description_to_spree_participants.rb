class AddDescriptionToSpreeParticipants < ActiveRecord::Migration[7.0]

  def change
    add_column :spree_participants, :description, :string
  end

end
