class RemoveSpreeUsersFromSpreeParticipants < ActiveRecord::Migration[5.2]
    def change
        remove_column :spree_participants, :user_id
    end
end