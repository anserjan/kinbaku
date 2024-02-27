module Dojo
  module Spree
    module User
      module AddBaseExtension
        
        def self.prepended(base)
          base.has_many :products, class_name: 'Spree::Product', inverse_of: :trainer
          base.has_many :deposits, inverse_of: :user
          base.has_many :participants, class_name: 'Spree::Participant', inverse_of: :user
          base.scope :trainers, -> { includes(:spree_roles).where("spree_roles.name": 'trainer') }
        end

        ::Spree::User.prepend self
      end
    end
  end
end