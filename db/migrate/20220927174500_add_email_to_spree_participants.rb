class AddEmailToSpreeParticipants < ActiveRecord::Migration[5.2]
    def change
        add_column :spree_participants, :email, :string
    end
end