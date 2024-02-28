module Dojo
  module Spree
    module Admin
      module ProductsController
        module AddUnlockCourse
          
          def unlock_course
            @product.course_confirmed = true
            @product.participants.each { |participant| participant.confirmed = true }
            @product.save
            redirect_back fallback_location: :admin_products_path
          end

          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end