module Dojo
  module Spree
    module Product
      module AddCreateBulk

        def create_bulk params
          count_date = params[:product][:date_and_time].to_datetime
          for i in 1..params[:repeat_amount].to_i do
            product = ::Spree::Product.create(
              name: params[:product][:name] + count_date.strftime(" %d.%m.%Y"),
              description: params[:product][:description],
              sku: set_sku(params[:product][:taxon_ids], count_date),
              price: params[:product][:price],
              date_and_time: count_date,
              taxon_ids: params[:product][:taxon_ids],
              available_on: params[:product][:available_on],
              shipping_category_id: params[:product][:shipping_category_id]
            )
            product.stock_items.all.each do |si|
              si.adjust_count_on_hand Dojo::Application.config.default_count_on_hand
              si.update_attribute(:backorderable, false)
            end
            if params[:repeat_pattern].eql? "weekly"
              count_date = params[:product][:date_and_time].to_datetime + i.weeks
            else
              count_date = params[:product][:date_and_time].to_datetime + i.months
            end
            product.save
          end
        end

        private

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
        
        def set_sku taxon_ids, date
          taxon_ids &&= taxon_ids.split(",").join("-")
          return "k-#{taxon_ids}#{date.strftime("-%Y%m%d")}"
        end

        ::Spree::Product.extend self
      end
    end
  end
end