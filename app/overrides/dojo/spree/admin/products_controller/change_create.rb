module Dojo
  module Spree
    module Admin
      module ProductsController
        module ChangeCreate
          require 'active_support'

          def create
            @image = File.open(Rails.root.join("app", "assets", "images", "placeholder_products.jpeg"))
            if params[:repeat_pattern].eql? "single"
              @product = ::Spree::Product.create( 
                name: set_default_name(params[:product][:date_and_time]),
                sku: set_sku(params[:product][:date_and_time]),
                description: set_description,
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
          
          def set_default_name date
            new_date = date.to_datetime.strftime(" %d.%m.%Y %H:%M")
            if params[:product][:name].present?
              return params[:product][:name] + new_date
            else
              return "Shibaritraining" + new_date
            end
          end

          def set_sku new_date
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

          def set_description
            # Product description
            # Zeilenumbruch
            # Ab
            # Level Name join
            # Orte Taxon Beschreibung
            # Link zu weiteren informationen
            description = ""
            taxon_training_id = ::Spree::Taxon.find_by(name: "Training").id.to_i
            if params[:product][:taxon_ids].present?
              taxons = ::Spree::Taxon.find(params[:product][:taxon_ids])
              # Level
              level_taxonomie = ::Spree::Taxonomy.find_by(name: "Level")
              if level_taxonomie.present?
                levels = taxons.select{|taxon| taxon.taxonomy_id.eql? level_taxonomie.id}
                description << "Ab " << levels.map{|level| level.name }.join(", ") << "<br><br>"
              end
              # Ort
              orte_taxonomie = ::Spree::Taxonomy.find_by(name: "Orte")
              if orte_taxonomie.present?
                ort = taxons.select{|taxon| taxon.taxonomy_id.eql? orte_taxonomie.id}
                ort = ort.first if ort.is_a? Array
                description << ort.description << "<br><br>"
              end
            end
            # link
            description << "<a href='#{::Spree::Page.find_by(slug: "/training-und-workshops").slug}'>Mehr Informationen...</a>"
            description << params[:product][:description] << "<br>" if params[:product][:description].present?
            return description
          end

          def create_bulk params
            count_date = params[:product][:date_and_time]
            description = set_description
            for i in 1..params[:repeat_amount].to_i do
              @product = ::Spree::Product.create(
                name: set_default_name(count_date),
                sku: set_sku(count_date),
                description: description,
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