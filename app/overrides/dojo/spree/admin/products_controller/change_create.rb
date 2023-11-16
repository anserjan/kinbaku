module Dojo
  module Spree
    module Admin
      module ProductsController
        module ChangeCreate

          def create
            if params[:repeat_pattern].eql? "single"
              @product = ::Spree::Product.create( 
                name: set_default_name(params),
                sku: set_sku(params),
                description: params[:product][:description],
                price: params[:product][:price],
                date_and_time: params[:product][:date_and_time],
                available_on: params[:product][:available_on],
                promotionable: params[:product][:promotionable],
                shipping_category_id: params[:product][:shipping_category_id], 
                taxon_ids: params[:product][:taxon_ids]
              )
              # set_stock_items(@product)
            else
              create_bulk(params)
            end
            return redirect_to admin_products_url        
          end

          private
          
          def set_default_name param
            if params[:product][:name].present?
              return params[:product][:name] + params[:product][:date_and_time].to_datetime.strftime(" %d.%m.%Y %H:%M")
            else
              return "Shibaritraining" + params[:product][:date_and_time].to_datetime.strftime(" %d.%m.%Y %H:%M")
            end
          end

          def set_taxons taxon_ids
            taxons = taxon_ids.split(",").reverse().map { |t| ::Spree::Taxon.find t }
            taxonomies = {}
            taxons.each do |t|
              taxonomies[t.taxonomy] = t.id if taxonomies.exclude? t.taxonomy          
            end
            return_taxon_ids = []
            taxonomies.each { |k,v| return_taxon_ids << v }
            return return_taxon_ids
          end

          def set_sku params
            params[:product][:taxon_ids].empty? ? taxon_ids = "" : taxon_ids = params[:product][:taxon_ids].split(",").join("-")
            return "k-#{taxon_ids}-#{params[:product][:date_and_time].to_datetime.strftime("%Y%m%d%H%M")}"
          end
          
          def set_stock_items product
            product.stock_items.first.adjust_count_on_hand Dojo::Application.config.default_count_on_hand
            product.stock_items.first.update_attribute(:backorderable, false)
            product.save!
          end

          def create_bulk params
            count_date = params[:product][:date_and_time].to_datetime
            for i in 1..params[:repeat_amount].to_i do
              @product = ::Spree::Product.create(
                name: set_default_name(params),
                sku: set_sku(params),
                description: params[:product][:description],
                price: params[:product][:price],
                date_and_time: count_date,
                available_on: params[:product][:available_on],
                shipping_category_id: params[:product][:shipping_category_id],
                taxon_ids: params[:product][:taxon_ids]
              )
              if params[:repeat_pattern].eql? "weekly"
                count_date = params[:product][:date_and_time].to_datetime + i.weeks
              else
                count_date = params[:product][:date_and_time].to_datetime + i.months
              end
              # set_stock_items(@product)
              @product.save
            end
          end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end