module Dojo
  module Spree
    module ContentBlock
      module AddRecentEvents

        def recent_events
          self.taxon.products.select{ |product| product.date_and_time > Time.now }.sort{ |p| p[:date_and_time] }
        end

        ::Spree::ContentBlock.prepend self
      end
    end
  end
end