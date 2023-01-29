module Dojo
  module Spree
    module Product
      module AddTrainerList

        def trainer_list
          @trainer_list = ::Spree::User.trainers
          return @trainers_collection = @trainer_list.collect { |trainer| [trainer.bill_address.name, trainer.id] }
        end

        ::Spree::Product.prepend self
      end
    end
  end
end