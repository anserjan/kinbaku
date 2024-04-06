module Dojo
  module Spree
    module Admin
      module ProductsController
        module DestroyParticipants

          def self.prepended(base)
            base.after_action :destroy_participants, only: :destroy
          end

          def destroy_participants
            @product.participants.each { |participant| participant.destroy }
          end

        end
      end
    end
  end
end