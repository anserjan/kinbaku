module Dojo
  module Spree
    module User
      module AddEmailAndName

        def name_and_email 
          return "#{self.bill_address.name}" if self.bill_address.present?
          return "#{self.email}"
        end

        ::Spree::User.prepend self
      end
    end
  end
end