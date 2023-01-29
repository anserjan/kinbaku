module Dojo
  module Spree
    module CheckoutController
      module AddBaseExtension

        def self.prepended(base)
          base.before_action :set_shipping_address, only: [:update, :create], unless: -> {@order.shipping_address.present?}
        end

        private

        def set_shipping_address
          @order.shipping_address = ::Spree::Address.create(
            name: params[:order][:bill_address_attributes][:name],
            address1: params[:order][:bill_address_attributes][:address1],
            zipcode: params[:order][:bill_address_attributes][:zipcode],
            city: params[:order][:bill_address_attributes][:city],
            country_id: params[:order][:bill_address_attributes][:country_id],
            phone: params[:order][:bill_address_attributes][:phone],
          )
        end

        ::Spree::CheckoutController.prepend self
      end
    end
  end
end