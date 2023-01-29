module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddBaseExtension

          def self.prepended(base)
            base.after_action :set_default_values, only: :create
          end
          
          private

          def set_default_values
            @product.stock_items.all.each do |si|
              si.adjust_count_on_hand 10
              si.update_attribute(:backorderable, false)
            end
          end
          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end