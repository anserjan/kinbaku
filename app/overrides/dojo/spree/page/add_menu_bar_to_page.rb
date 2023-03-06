module Dojo
  module Spree
    module Page
      module AddMenuBarToPage


        def self.prepended(base)
          base.has_one :menu_bar
        end

        ::Spree::Page.prepend self
      end
    end
  end
end