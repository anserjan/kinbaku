class AddSpreeParticipantToSpreeUsers < ActiveRecord::Migration[5.2]
    def change 
        add_column :spree_users, :participant_id, :integer
    end
end