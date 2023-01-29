# frozen_string_literal: true

class CreateSpreeParticipants < ActiveRecord::Migration[5.2]
    def up
        create_table :spree_participants do |t|
            t.belongs_to :product
            t.belongs_to :user
            t.timestamps
        end
    end
  
    def down
        drop_table :spree_participants
    end
end
  