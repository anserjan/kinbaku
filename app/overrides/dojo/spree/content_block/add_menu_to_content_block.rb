module Dojo
  module Spree
    module ContentBlock
      module AddMenuToContentBlock

        def self.prepended(base)
          base.has_many :menus, class_name: "Spree::Menu"
        end

        ::Spree::ContentBlock.prepend self
      end
    end
  end
end