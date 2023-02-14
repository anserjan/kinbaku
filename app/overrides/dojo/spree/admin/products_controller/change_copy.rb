module Dojo
  module Spree
    module Admin
      module ProductsController
        module ChangeCopy

          def clone
            @product = ::Spree::Product.find_by(slug: params[:id])
            @new = ::Spree::Product.create(
              name: "COPY OF + " + @product.name,
              slug: "copy-of-" + @product.slug,
              description: @product.description,
              price: @product.price.to_i,
              date_and_time: @product.date_and_time,
              available_on: @product.available_on,
              sku: "COPY OF " + @product.sku,
              taxon_ids: @product.taxons.map { |t| t.id },
              shipping_category_id: @product.shipping_category_id
            )
            @new.stock_items.first.adjust_count_on_hand @product.stock_items.first.count_on_hand
            @new.stock_items.first.update_attribute(:backorderable, false)
            redirect_to edit_admin_product_url(@new)
          end
          
          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end