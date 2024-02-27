class AddConfirmedAndUserIdToSpreeParticipants < ActiveRecord::Migration[7.0]

  def change
    add_column :spree_participants, :confirmed, :boolean, default: false
    add_column :spree_participants, :user_id, :integer
    remove_column :spree_participants, :email, :string
    remove_column :spree_participants, :description, :string
  end

end