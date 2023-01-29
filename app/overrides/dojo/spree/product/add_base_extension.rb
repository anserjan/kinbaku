module Dojo
  module Spree
    module Product
      module AddAssociations
        
        def self.prepended(base)
          base.has_many :participants, class_name: "Spree::Participant", inverse_of: :product
          base.belongs_to :trainer, class_name: "Spree::User", inverse_of: :products, optional: true
          base.validates :date_and_time, presence: true
        end

        ::Spree::Product.prepend self
      end
    end
  end
end