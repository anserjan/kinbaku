module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddCreateBulk

          def create_bulk
            ::Spree::Product.create_bulk(params)
            return redirect_to admin_products_url
          end
            
          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end
