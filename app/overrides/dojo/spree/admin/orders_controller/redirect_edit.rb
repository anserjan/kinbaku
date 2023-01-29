module Dojo
  module Spree
    module Admin
      module OrdersController
        module RedirectEdit

          def edit
            redirect_to cart_admin_order_url(@order)
          end

        ::Spree::Admin::OrdersController.prepend self
        end
      end
    end
  end
end