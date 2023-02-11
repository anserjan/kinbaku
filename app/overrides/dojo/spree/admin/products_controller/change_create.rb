module Dojo
  module Spree
    module Admin
      module ProductsController
        module ChangeCreate

          def create
            if params[:repeat_pattern].eql? "single"
              @product = ::Spree::Product.create(
                name: params[:product][:name],
                description: params[:product][:description],
                price: params[:product][:price],
                date_and_time: params[:product][:date_and_time],
                available_on: params[:product][:available_on],
                promotionable: params[:product][:promotionable],
                shipping_category_id: params[:product][:shipping_category_id], 
                taxon_ids: params[:product][:taxon_ids]
              )
            else
              ::Spree::Product.create_bulk params
            end
            return redirect_to admin_products_url         
          end
          
          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end