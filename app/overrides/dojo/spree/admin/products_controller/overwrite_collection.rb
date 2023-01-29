module Dojo
  module Spree
    module Admin
      module ProductsController
        module OverwriteCollection

          def collection
            return @collection if @collection
            params[:q] ||= {}
            params[:q][:s] ||= "date_and_time asc"
            # @search needs to be defined as this is passed to search_form_for
            @search = super.ransack(params[:q])
            @collection = @search.result.
                  order(id: :asc).
                  includes(product_includes).
                  page(params[:page]).
                  per(::Spree::Config[:admin_products_per_page])
            end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end