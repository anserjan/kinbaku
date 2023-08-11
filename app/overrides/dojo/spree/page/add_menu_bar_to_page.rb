module Dojo
  module Spree
    module Page
      module AddMenuToPage


        def self.prepended(base)
          base.belongs_to :menu, class_name: "Spree::Menu", optional: true
        end

        ::Spree::Page.prepend self
      end
    end
  end
end