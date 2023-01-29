module Dojo
  module Spree
    module Order
      module AddBaseExtension

        def self.prepended(base)
          base.remove_checkout_step :delivery
        end
  
        ::Spree::Order.prepend self
      end
    end
  end
end