module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddNewBulk

          def new_bulk
            invoke_callbacks(:new_action, :before)
            @product = ::Spree::Product.new
          end
          
          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end