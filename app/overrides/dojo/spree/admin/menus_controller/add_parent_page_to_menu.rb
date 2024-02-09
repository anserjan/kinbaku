module Dojo
  module Spree
    module Admin
      module MenusController
        module AddParentPageToMenu

          def self.prepended(base)
            base.after_action :set_page, only: [:update, :create], if: -> { @menu.parent.present? && @menu.parent.page.present? && @menu.page.nil? }
          end

          private

          def set_page
            @menu.page = @menu.parent.page
          end

          ::Spree::Admin::MenusController.prepend self
        end
      end
    end
  end
end