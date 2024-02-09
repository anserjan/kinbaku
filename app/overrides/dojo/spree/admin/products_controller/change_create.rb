module Dojo
  module Spree
    module Admin
      module ProductsController
        module ChangeCreate

          def create
            @image = File.open(Rails.root.join("app", "assets", "images", "placeholder_products.jpeg"))
            if params[:repeat_pattern].eql? "single"
              @product = ::Spree::Product.create( 
                name: set_default_name(params, params[:product][:date_and_time]),
                sku: set_sku(params, params[:product][:date_and_time]),
                description: params[:product][:description],
                price: params[:product][:price],
                date_and_time: params[:product][:date_and_time],
                available_on: params[:product][:available_on],
                promotionable: params[:product][:promotionable],
                shipping_category_id: params[:product][:shipping_category_id], 
                taxon_ids: params[:product][:taxon_ids]
              )
              set_stock_items
              set_default_image
              @product.save
            else
              create_bulk(params)
            end
            return redirect_to admin_products_url        
          end

          private
          
          def set_default_name params, date
            new_date = date.to_datetime.strftime(" %d.%m.%Y %H:%M")
            if params[:product][:name].present?
              return params[:product][:name] + new_date
            else
              return "Shibaritraining" + new_date
            end
          end

          def set_sku params, new_date
            params[:product][:taxon_ids].empty? ? taxon_ids = "" : taxon_ids = params[:product][:taxon_ids].split(",").join("-")
            return "k-#{taxon_ids}-#{new_date.to_datetime.strftime("%Y%m%d%H%M")}"
          end
          
          def set_stock_items
            @product.stock_items.first.adjust_count_on_hand Dojo::Application.config.default_count_on_hand
            @product.stock_items.first.update_attribute(:backorderable, false)
          end

          def set_default_image
            @product.images.create(attachment: @image)
          end

          def create_bulk params
            count_date = params[:product][:date_and_time]
            for i in 1..params[:repeat_amount].to_i do
              @product = ::Spree::Product.create(
                name: set_default_name(params, count_date),
                sku: set_sku(params, count_date),
                description: params[:product][:description],
                price: params[:product][:price],
                date_and_time: count_date,
                available_on: params[:product][:available_on],
                promotionable: params[:product][:promotionable],
                shipping_category_id: params[:product][:shipping_category_id],
                taxon_ids: params[:product][:taxon_ids]
              )
              if params[:repeat_pattern].eql? "weekly"
                count_date = params[:product][:date_and_time].to_datetime + i.weeks
              else
                count_date = params[:product][:date_and_time].to_datetime + i.months
              end
              set_stock_items
              set_default_image
              @product.save
            end
          end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end