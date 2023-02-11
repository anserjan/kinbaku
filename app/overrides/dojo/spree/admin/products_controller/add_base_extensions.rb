module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddBaseExtensions

          def self.prepended(base)
            base.after_action :set_default_values, only: [:create]
          end

          private

          def set_default_values
            @product.stock_items.all.each do |si|
              si.adjust_count_on_hand Dojo::Application.config.default_count_on_hand
              si.update_attribute(:backorderable, false)
            end
            params[:product][:taxon_ids].empty? ? taxon_ids = "" : taxon_ids = params[:product][:taxon_ids].split(",").join("-")
            @product.sku = "k-#{taxon_ids}-#{params[:product][:date_and_time].to_datetime.strftime("%Y%m%d%H%M")}"
            @product.save
          end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end
