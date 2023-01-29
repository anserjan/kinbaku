module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddLocationAfterSave

          private
          
          def location_after_save
            if saved_trainer?
              return admin_product_participants_path(@product)
            else
              return collection_url
            end
          end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end