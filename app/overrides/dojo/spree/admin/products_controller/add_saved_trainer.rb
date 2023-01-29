module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddSavedTrainer

          private

          def saved_trainer?
            params[:product].include? "trainer_id"
          end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end