module Dojo
  module Spree
    module User
      module AddCashListFunction

        def name_and_email
          "#{self.bill_address.name} (#{self.email})"
        end

        ::Spree::User.prepend self
      end
    end
  end
end