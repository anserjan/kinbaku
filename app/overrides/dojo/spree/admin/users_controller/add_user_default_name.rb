module Dojo
  module Spree
    module Admin
      module UsersController
        module AddUserDefaultName

          def self.prepended(base)
            base.after_action :set_default_name, only: [:create], if: -> { @user.present? && @user.bill_address.nil? }
          end

          private

          def set_default_name
            @user.bill_address = ::Spree::Address.create(
              name: params[:user][:email].split("@")[0],
              address1:"Default",
              zipcode: "Default",
              country: ::Spree::Country.find_by(iso3: "DEU"),
              city: "Default"
            )
          end

          ::Spree::Admin::UsersController.prepend self
        end
      end
    end
  end
end

