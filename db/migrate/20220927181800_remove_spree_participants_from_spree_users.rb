class RemoveSpreeParticipantsFromSpreeUsers < ActiveRecord::Migration[5.2]
    def change
        remove_column :spree_users, :participant_id, :integer
    end
end