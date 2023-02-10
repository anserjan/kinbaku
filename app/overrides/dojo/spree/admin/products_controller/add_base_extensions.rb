module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddBaseExtensions

          def self.prepended(base)
            
          end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end
