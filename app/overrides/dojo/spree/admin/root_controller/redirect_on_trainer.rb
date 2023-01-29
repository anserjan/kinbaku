module Dojo
  module Spree
    module Admin
      module RootController
        module RedirectOnTrainer

          private

          def admin_root_redirect_path
            if can?(:show, Spree::Order) && can?(:admin, Spree::Order)
              spree.admin_orders_path
            elsif can?(:admin, :dashboards) && can?(:home, :dashboards)
              spree.home_admin_dashboards_path
            elsif can?(:admin, ::Spree::TrainerCashList)
              admin_trainer_cash_lists_url
            else
              # Invoke the unauthorized redirect, which will ideally go to the login controller
              # of the users chosen authorization implimentation. For devise this is /admin/login.
              #
              # This is done so devise redirects back to this controller, instead of the one specified
              # below, so this controller can use the user that is required for the path to
              # be calculated.
              raise CanCan::AccessDenied
            end
          end


          ::Spree::Admin::RootController.prepend self
        end
      end
    end
  end
end