module Dojo
  module Spree
    module Page
      module AddMenuBarToPage


        def self.prepended(base)
          base.belongs_to :menu_bar
        end

        ::Spree::Page.prepend self
      end
    end
  end
end