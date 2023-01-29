module Dojo
  module Spree
    module Product
      module AddCreateBulk

        def create_bulk params
          if params[:repeat_pattern].eql? "weekly"
            create_weekly(params)
          elsif params[:repeat_pattern].eql? "monthly"
            create_monthly(params)
          end
        end

        private

        def create_weekly params
          count_date = params[:product][:date_and_time].to_datetime
          for i in 1..params[:repeat_amount].to_i do
            product = ::Spree::Product.create(
              name: set_name(count_date),
              description: set_description(set_taxons(params[:product][:taxon_ids]), count_date),
              sku: set_sku(params[:product][:taxon_ids], count_date),
              price: Dojo::Application.config.default_price,
              date_and_time: count_date,
              taxon_ids: set_taxons(params[:product][:taxon_ids]),
              available_on: Time.current,
              shipping_category_id: set_shipping_category
            )
            set_default_values product
            product.save
            count_date = params[:product][:date_and_time].to_datetime + i.weeks
          end
        end

        def create_monthly params
          count_date = params[:product][:date_and_time].to_datetime
          for i in 1..params[:repeat_amount].to_i do
            product = ::Spree::Product.create(
              name: set_name(count_date),
              description: set_description(set_taxons(params[:product][:taxon_ids]), count_date),
              sku: set_sku(params[:product][:taxon_ids], count_date),
              price: Dojo::Application.config.default_price,
              date_and_time: count_date,
              taxon_ids: set_taxons(params[:product][:taxon_ids]),
              available_on: Time.current,
              shipping_category_id: set_shipping_category
            )
            set_default_values product
            product.save
            count_date = params[:product][:date_and_time].to_datetime + i.months
          end
        end

        def set_shipping_category
          ::Spree::ShippingCategory.all.select { |ship_cat| ship_cat.name.downcase.eql? "default"}.first.id
        end

        def set_default_values product
          product.stock_items.all.each do |si|
            si.adjust_count_on_hand 15
            si.update_attribute(:backorderable, false)
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

        def set_name date
          return I18n.t("spree.course") + date.strftime(" %d.%m.%Y")
        end
        
        def set_sku taxon_ids, date
          taxon_ids &&= set_taxons(taxon_ids).split(",").join("-")
          return "k-#{taxon_ids}#{date.strftime("-%Y%m%d")}"
        end

        def set_description taxons, date
          description = "<p>"
          taxons.each do |taxon|
            description += "#{::Spree::Taxon.find(taxon).name} <br />"
          end
          description += "#{date.strftime(" %A %d. %B %Y")}</p>"
          return description
        end

        ::Spree::Product.extend self
      end
    end
  end
end