module Dojo
  module Spree
    module Order
      module AddBaseExtension

        def self.prepended(base)
          base.remove_checkout_step :delivery
          base.remove_checkout_step :address
        end
  
        ::Spree::Order.prepend self
      end
    end
  end
end